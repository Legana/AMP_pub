Build a training dataset for ampir
================

## Background Dataset

As our basis for a background dataset we use all reviewed proteins in
the Swissprot database. Our goal is to use fairly minimal filtering on
these so that they have roughly the same composition as a typical set of
non-AMP proteins in a genome. The filtering is as follows;

1.  Use cd-hit to cluster sequences to 50% identity
2.  Remove any sequences in the Uniprot AMP dataset
3.  Check that no sequences in the background dataset contain
    non-standard amino acids.

**Step 1** is computationally intensive and was performed using cd-hit
using SwissProt data downloaded on 7 April 2020. The resulting clustered
file is included in the data distribution as
`uniprot-filtered-reviewed_yes_50.fasta`

``` bash
cd-hit -i uniprot-filtered-reviewed_yes.fasta -o uniprot-filtered-reviewed_yes_50.fasta -c 0.50  -n 3 -T 32 -M 300000
```

**Step 2** To exclude any potential AMPs from this dataset we use the
unix `comm` command to create a list of all SwissProt identifiers in the
clustered Swissprot data that are not present in the Uniprot AMP
database. This is then piped to another unix command `shuf` which takes
a random subset of the identifiers and this is finally piped to
`samtools faidx` which extract the relevant fasta entries and writes
them to a file.

At this stage we keep more background proteins than needed for a
balanced dataset. This is for several reasons. Firstly a small number of
background proteins might be removed under additional filtering
criteria. Secondly we may choose to use an unbalanced dataset in order
to achieve better overall performance on whole genome scans.

``` bash
comm -23 \
  <(cat uniprot-filtered-reviewed_yes_50.fasta | bioawk -c fastx '{print $name}' | sort) \
  <(cat amp_databases/uniprot-keyword__Antimicrobial+\[KW-0929\]_.fasta | bioawk -c fastx '{print $name}' | sort) | \
  shuf -n 10000 | \
  xargs samtools faidx uniprot-filtered-reviewed_yes_50.fasta > amp_databases/ampir_negative070420_50.fasta
```

**Step 3** We read both target and background datasets and then apply a
filter to remove any with non-standard amino acids.

## Training and Test Sets

Using the target and background proteins identified above we create
paired training and test sets. Initially these have bg/tg ratio of 1:1.
In all cases we use 80% of data for training and reserve 20% for
testing. These datasets are saved to cache and used for model training
and tuning scripts.
