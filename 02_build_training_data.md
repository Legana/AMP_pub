Build a training dataset for ampir
================

In the `ampir` defaults models we distinguish between those designed to
predict protein precursors and those for mature peptides. Positive
datasets for both are outlined in
[01\_collate\_databases](01_collate_databases.md).

## Precursor Background Dataset

As our basis for a background dataset we use all reviewed proteins in
the Swissprot database. Our goal is to use fairly minimal filtering on
these so that they have roughly the same composition as a typical set of
non-AMP proteins in a genome. The filtering is as follows;

1.  Use cd-hit to cluster sequences to 90% identity
2.  Remove any sequences in the Uniprot AMP dataset
3.  Check that no sequences in the background dataset contain
    non-standard amino acids.
4.  Remove sequences with AMP-like lengths 50AA , and very large lengths
    (\>500AA)

**Step 1** is computationally intensive and was performed using cd-hit
using SwissProt data downloaded on 7 April 2020. The resulting clustered
file is included in the data distribution as
`uniprot-filtered-reviewed_yes_90.fasta`

``` bash
cd-hit -i uniprot-filtered-reviewed_yes.fasta -o uniprot-filtered-reviewed_yes_90.fasta -c 0.90 -g 1 -T 32 -M 300000
```

**Step 2** To exclude any potential AMPs from this dataset we use the
unix `comm` command to create a list of all SwissProt identifiers in the
clustered Swissprot data that are not present in the Uniprot AMP
database. For creating a balanced dataset, this is then piped to another
unix command `shuf` which takes a random subset of the identifiers and
this is finally piped to `samtools faidx` which extracts the relevant
fasta entries and writes them to a file.

At this stage we keep more background proteins than needed for a
balanced dataset. This is for several reasons. Firstly a small number of
background proteins might be removed under additional filtering
criteria. Secondly we may choose to use an unbalanced dataset in order
to achieve better overall performance on whole genome scans.

``` bash
comm -23 \
  <(cat uniprot-filtered-reviewed_yes_90.fasta | bioawk -c fastx '{print $name}' | sort) \
  <(cat amp_databases/uniprot-keyword__Antimicrobial+\[KW-0929\]_.fasta | bioawk -c fastx '{print $name}' | sort) | \
  shuf -n 50000 | \
  xargs samtools faidx uniprot-filtered-reviewed_yes_90.fasta > amp_databases/ampir_negative90.fasta
```

**Steps 3 and 4** We read both target and background datasets and then
apply a filter to remove any with non-standard amino acids.

## Mature Peptide Background Dataset

As a background dataset for mature peptides we have several options. One
would be to simply take peptides as random substrings from the full
protein database. Another is to select proteins in swissprot with
lengths similar to mature peptides. This latter option is probably more
representative of a real classification problem where we decide apriori
to only look at short peptides within a larger dataset and wish to
distinguish AMPs from other typical short peptides/proteins like toxins.

## Training and Test Sets

Using the target and background proteins identified above we create
paired training and test sets. Initially these have bg/tg ratio of 1:1.
In all cases we use 80% of data for training and reserve 20% for
testing. These datasets are saved to cache and used for model training
and tuning scripts.

For whole genome benchmarking we remove Human and Arabidopsis data
