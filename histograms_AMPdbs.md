AMP databases sequence length histograms
================

#### Compare sequence lengths of AMP databases

Read AMP
databases

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
```

Combine databases and calculate sequence length

``` r
combined_dbs <- rbind(APD, dbAMP, DRAMP, swissprot) %>% 
  select(seq_name, seq_aa, description, database)

combined_dbs <- mutate(combined_dbs, seq_len = nchar(combined_dbs$seq_aa))
```

Plot sequence lengths of AMP databases

``` r
ggplot(combined_dbs) +
  geom_histogram(aes(x = seq_len)) +
  facet_wrap(~database, scales = "free_x") +
  labs(x = "Sequence length", y = "Frequency")
```

![](histograms_AMPdbs_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

SwissProt only

``` r
sp <- filter(combined_dbs, database == "SwissProt")

ggplot(sp) +
  geom_histogram(aes(x = seq_len)) +
  labs(x = "Sequence length", y = "Frequency") +
  scale_x_continuous(breaks = c(0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000),
                                limits = c(0, 1000))
```

![](histograms_AMPdbs_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

#### Compare positive and negative data without using APD and DRAMP

Read and combine data and calculate sequence length

``` r
tg_no_APD_DRAMP <- read_faa("cache/positive032020_98.fasta") %>%
  add_column(Label = "Tg") 

bg_no_APD_DRAMP  <- read_faa("cache/negative032020_98.fasta") %>%
  add_column(Label = "Bg")

bg_tg_no_APD_DRAMP <- rbind(tg_no_APD_DRAMP, bg_no_APD_DRAMP)

bg_tg_no_APD_DRAMP <- mutate(bg_tg_no_APD_DRAMP, seq_len = nchar(bg_tg_no_APD_DRAMP$seq_aa))
```

Plot the sequence length of the negative and positive background
obtained from SwissProt and dbAMP

``` r
ggplot(bg_tg_no_APD_DRAMP) +
  geom_histogram(aes(x = seq_len)) +
  labs(x = "Sequence length", y = "Frequency") +
  facet_wrap(~Label, scales = "free_x") 
```

![](histograms_AMPdbs_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->
