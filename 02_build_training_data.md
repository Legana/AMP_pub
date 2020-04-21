Build a training dataset for ampir
================

Since `ampir` uses supervised learning to create a classifier it needs a
training set consisting of confirmed “positive” AMP (or precursor)
sequences and also a background dataset consisting of non-AMP sequences.
Construction of this training data is a critical step and has an
enormous effect on the performance of the predictor. In
[01\_collate\_databases](01_collate_databases.md) the process of
positive dataset construction is decribed. Here we describe how the
background data and overall training sets are built.

## Precursor Background Dataset

As our basis for a background dataset we use all reviewed proteins in
the UniProt database. Our goal is to use fairly minimal filtering on
these so that they have roughly the same composition as a typical set of
non-AMP proteins in a genome. The filtering is as follows:

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

**Step 3 and 4** are fairly trivial. Length filters are applied and
sequences with non-standard AA’s removed

## Mature Peptide Background Dataset

As a background dataset for mature peptides we have several options. One
would be to simply take peptides as random substrings from the full
protein database. Another is to select proteins in swissprot with
lengths similar to mature peptides. This latter option is probably more
representative of a real classification problem where we decide apriori
to only look at short peptides within a larger dataset and wish to
distinguish AMPs from other typical short peptides/proteins like toxins.
Specifically the method used for constructing a mature peptide
background for `ampir` is;

1.  Use non-AMP sequences clustered to 90% identity from SwissProt as a
    starting point
2.  Keep only sequences \>20AA and \<100AA
3.  Remove sequences with non-standard amino acids
4.  Sample this dataset randomly so that it is balanced (same number of
    peptides as the positive data)

## Training and Test Sets

Using the target and background proteins identified above we create
paired training and test sets. In all cases we use 80% of data for
training and reserve 20% for testing. These datasets are saved to cache
and used for model training and tuning scripts. The training sets
created are;

1.  Precursor training (balanced mix of target and background
    precursors)
2.  Mature peptide training
3.  Precursor training but with Human and Arabidopsis sequences removed
    (for benchmarking purposes)
