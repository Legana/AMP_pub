Databases used for testing and training ampir
================

# Public AMP databases

The following databases were accessed as of March 2020. All ampir models
were trained using data from one or more of these databases (see details
below).

Four recently updated antimicrobial peptide (AMP) databases were used:

  - [APD 3](http://aps.unmc.edu/AP/) by [Wang et
    al. 2016](https://academic.oup.com/nar/article/44/D1/D1087/2503090)
  - [DRAMP 2.0](http://dramp.cpu-bioinfor.org/) by [Kang et
    al. 2019](https://www.ncbi.nlm.nih.gov/pubmed/31409791)
      - [DRAMP GitHub](https://github.com/CPUDRAMP/DRAMP2.0)
  - [dbAMP](http://140.138.77.240/~dbamp/index.php) by [Jhong et
    al. 2018](https://www.ncbi.nlm.nih.gov/pubmed/30380085)
  - [SwissProt](https://www.uniprot.org/uniprot/?query=keyword:%22Antimicrobial%20%5BKW-0929%5D%22%20OR%20%22antimicrobial%20peptide%22&fil=reviewed%3Ayes&sort=score)
    using the search term “antimicrobial peptide” and the keyword
    “Antimicrobial”.

Raw downloads for these databases are included in the data distribution
for this repository. After unpacking they should be present at the
following file
locations

| Database Name | File                                                                                  |
| ------------- | ------------------------------------------------------------------------------------- |
| APD 3         | `raw_data/APD_032020.xlsx`                                                            |
| DRAMP General | `raw_data/DRAMP_general_amps.xlsx`                                                    |
| DRAMP Natural | `dramp_nat_tidy.fasta`                                                                |
| dbAMP         | `raw_data/dbAMPv1.4.xlsx`                                                             |
| SwissProt     | `raw_data/uniprot-keyword__Antimicrobial+[KW-0929]_+OR+_antimicrobial+peptide%--.tab` |

### APD

The [Antimicrobial Peptide Database](http://aps.unmc.edu/AP/main.php)
was last updated March 16 2020 and contains 3,177 AMPs. An outdated
(2017) AMP sequence list is downloadable from
<http://aps.unmc.edu/AP/downloads.php> which currently contains 2,338
sequences. To include the updated AMP list, the [web query
interface](http://aps.unmc.edu/AP/database/mysql.php) was used to obtain
the full 3,177 AMPs along with sufficient metadata to filter unwanted
entries.

### DRAMP

[DRAMP’s download page](http://dramp.cpu-bioinfor.org/downloads/),
provides access to a general AMP dataset (which contains both natural
and synthetic AMPs). This general dataset was posted on 06/08/2019 but
according to the “news and events” section, the [natural
dataset](http://dramp.cpu-bioinfor.org/browse/NaturalData.php) has been
updated several times since then. Because the natural dataset contains
the AMPs we are interested in, and is also more regularly updated (it
currently contains 4,394 sequences), the natural AMP data was obtained
using a scrape script.

``` bash
for i in $(seq -s ' ' 1 220);do

curl "http://dramp.cpu-bioinfor.org/browse/NaturalData.php?&end=5&begin=1&pageNow=${i}" -o p${i}.html
amp_ids=$(cat p${i}.html | grep -oE '(DRAMP[0-9]+)' | sort -u | tr '\n' ' ' | sed 's/ /%20/g')
curl "http://dramp.cpu-bioinfor.org/down_load/download.php?load_id=${amp_ids}&format=fasta" -o p${i}.fasta

done
```

This scrape script results in a html file for each webpage plus a FASTA
file containing the sequences in FASTA format for each page. The FASTA
files were concatenated into a single FASTA file and tidied up to remove
blank lines in the files.

``` bash
cat *.fasta >> dramp_nat.fasta
sed '/^$/d' dramp_nat.fasta > dramp_nat_tidy.fasta
```

### dbAMP

The latest release of dbAMP is from 06/2019 and was downloaded from
their [download page](http://140.138.77.240/~dbamp/download.php). It
contains 4,270 experimentally verified natural and synthetic
AMPs.

``` bash
wget http://140.138.77.240/~dbamp/download/dbAMPv1.4.tar.gz -O raw_data/dbAMPv1.4.tar.gz
tar -xf raw_data/dbAMPv1.4.tar.gz -C raw_data
```

### SwissProt

AMPs were collected from UniProt using the following search terms:
“keyword:”Antimicrobial \[KW-0929\]" OR “antimicrobial peptide” AND
reviewed:yes" (3,546 sequences).

# Database used for the ampir default model

The default SVM model included with ampir is trained on a high quality
general database consisting of verified natural AMPs from across all of
the public databases listed above. It is as inclusive as possible in
order to capture a range of AMP types and ensure a large database for
training and testing.

**Read raw data**

Read all raw public databases, convert to a common format and combine
into a single
table

``` r
APD <- readxl::read_xlsx("raw_data/APD_032020.xlsx", col_names = c("seq_name", "description", "seq_aa")) %>% 
  mutate(database = "APD") %>% 
  filter(!grepl("Synthetic|synthetic", description))

DRAMP <- read_faa("raw_data/dramp_nat_tidy.fasta") %>%
  separate(seq_name, into = c("seq_name","description"), sep ="\\|") %>% 
  filter(!grepl("Predicted", seq_name)) %>% 
  mutate(database = "DRAMP")

dbAMP <- readxl::read_xlsx("raw_data/dbAMPv1.4.xlsx") %>%
  filter(!grepl('Synthetic|synthetic', dbAMP_Taxonomy)) %>%
  select(seq_name = dbAMP_ID, description = Activity, seq_aa = Sequence) %>% 
  mutate(database = "dbAMP")

swissprot <- read_tsv("raw_data/uniprot-keyword__Antimicrobial+[KW-0929]_+OR+_antimicrobial+peptide%--.tab") %>%
  select(seq_name = Entry, description =  `Protein names`, seq_aa = Sequence) %>% 
  mutate(database = "SwissProt") 

combined_dbs <- rbind(APD, dbAMP, DRAMP, swissprot) %>% 
  select(seq_name, seq_aa, description, database)
```

**Apply filters**

  - Very large proteins are excluded because in some cases (eg Swissprot
    derived proteins) they are not true AMPs and even in rare cases
    where large proteins are genuine AMPs their physicochemical
    properties are likely to be wildly different from the majority
    (which have lengths between 50 and 300AA).
  - Identical sequences are also removed at this stage
  - Sequences with non standard amino acids are also removed

<!-- end list -->

``` r
combined_filtered_dbs <- combined_dbs %>%
  distinct(seq_aa, .keep_all = TRUE) %>%
  as.data.frame() %>%
  remove_nonstandard_aa()
```

Write file to FASTA

``` r
df_to_faa(combined_filtered_dbs, "cache/positive032020.fasta")
```

Use cd-hit to remove highly similar sequences (which leaves 5673
AMPs)

``` bash
cd-hit -i cache/positive032020.fasta -o cache/positive032020_98.fasta -c 0.98 -g 1
```
