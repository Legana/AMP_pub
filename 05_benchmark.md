Benchmarking
================

When benchmarking the performance of AMP predictors a number of
important factors need to be considered;

1.  Any benchmark dataset will likely include some AMPs used for
    training in one or more of the predictors. Since most predictors are
    not open source they are provided as-is and it is almost impossible
    to devise a completely impartial benchmark based on AMPs that were
    not used to train any of the predictors.
2.  An existing benchmark dataset provided by [Xiao et
    al. 2013](https://doi.org/10.1016/j.ab.2013.01.019) has been
    adopted by several subsequent authors but the composition of this
    dataset has the following issues;
      - Positive (AMP) cases in this dataset are mature peptides whereas
        in a genome scan only precursors sequences are usually
        available.
      - The negative cases in the dataset have a length distribution
        which suggests they are most likely full-length proteins (much
        longer than the positive cases). This means that predictors
        trained to perform well on this dataset might achieve high
        accuracy simply by classifying sequences into mature vs
        full-length proteins instead of AMP / non-AMP (the desired
        behaviour).
3.  A realistic test of AMP prediction in genome-wide scans should use a
    benchmark dataset that is highly unbalanced, just as a real genome
    protein set would be. For example in the Arabidopsis genome AMPs
    make up less than 1% of proteins.  
4.  Real genomes contain non-AMP proteins that may resemble AMPs in some
    ways (eg secreted proteins, transmembrane proteins) and which will
    therefore make the classification problem more difficult. Any
    benchmark that does not include these proteins will most likely
    provide a inflated estimates of accuracy.

In light of these issues we tested the performance of ampir against
contemporary AMP predictors using several benchmark datasets.

1.  The [Xiao et al. 2013](https://doi.org/10.1016/j.ab.2013.01.019)
    benchmark dataset. This was included in the interests of consistency
    with benchmarking from previous work but results from this benchmark
    are not likely to reflect real-world performance.
2.  A subset of the ampir mature peptide training data which we set
    aside for model evaluation and was not used in training. This
    dataset consists of known AMP mature peptides as positive cases and
    non-AMP mature peptides as negative cases. It should reflect
    real-world performance in situations where a researcher has access
    to a mature peptide sequence (eg by mass spectrometry) and wishes to
    determine if it is an AMP or another type of small peptide such as a
    toxin or neuropeptide.
3.  A whole-genome scanning benchmark for species with the best
    available annotated AMP repertoires. We chose an animal (Human) and
    a plant (Arabidopsis thaliana) for this
test.

##### Table 1: AMP predictors with their papers and model accessiblity

| AMP predictor name | Reference                                                           | Availability                                                                          |
| ------------------ | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| AMP scanner v2     | [Veltri et al. 2018](https://doi.org/10.1093/bioinformatics/bty179) | [amp scanner webserver](https://www.dveltri.com/ascan/v2/ascan.html)                  |
| amPEP              | [Bhadra et al. 2018](https://doi.org/10.1038/s41598-018-19752-w)    | [MATLAB source code](https://sourceforge.net/projects/axpep/files/AmPEP_MATLAB_code/) |
| iAMPpred           | [Meher et al. 2017](https://doi.org/10.1038/srep42362)              | [iAMPpred webserver](http://cabgrid.res.in:8080/amppred/)                             |

AMP predictors were accessed in ***April 2020***

### Mature peptide benchmarks

Both the [Xiao et al. 2013](https://doi.org/10.1016/j.ab.2013.01.019)
benchmark and the ampir testing set should are focussed on mature
peptide prediction since mature peptides form the bulk of positive
cases). The benchmarks differ most substantially in the composition of
their background datasets. The Xiao et al background data has a peak in
length distribution around 80-90AA whereas for the ampir test set this
is more similar to the target set at around 40AA.

The plot below shows performance of all predictors in the form of
receiver operating characteristic (ROC) curves. These show the tradeoff
between false positive rate and true positive rate (also called recall).
A few points to note from this plot;

  - The `ampir_mature` model performs well on both datasets whereas the
    `ampir_precursor` model performs very poorly. Users of `ampir`
    should therefore take care to always select the appropriate model
    for their task depending on the nature of the input data (mature
    peptides or precursor proteins).
  - Some predictors do not perform well at the extremes of the ROC
    curve. This reflects the ability of the predictor to produce
    accurate probability values across the full range of probabilities.
    In the case of ampscan v2 for example we see that its curve does not
    extend into the low false positive regime. This is because its
    probability distribution is strongly concentrated at the extremes (0
    and 1), and a relatively large number of non-AMP peptides have been
    assigned a probability of 1.
  - The best performing predictors in the low FP regime are `ampep` and
    `ampir`

![](05_benchmark_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

**Figure 5.1:** Performance of a range of AMP predictors against two
mature peptide testing datasets.

### Real Genome Benchmark

Since we are building a model for the purpose of genome-wide prediction
a realistic test must involve data with composition similar to that of a
complete proteome.

One approach is to use whole genomes that have been well annotated for
AMPs. Here we chose the Human and Arabidopsis genomes because these
represent phylogenetically distinct lineages (animals and plants) are
their genomes among the best annotated for AMPs. A few other points to
note about this test are;

  - We were able to run this test for `ampir`, `ampep` and `ampscan_v2`
    only because other predictors were unable to handle the large number
    of candidates sequences (~100k) in a practical manner.
  - We used a specially generated model for ampir that was trained
    without Human or Arabidopsis proteins to avoid any potential for
    overfitting resulting in inflacted accuracy estimates in this test.
    It should be noted that other predictors would have no such
    restriction.

![](05_benchmark_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

**Figure 5.2:** Performance of various AMP predictors in classifying
whole proteome data for Human and Arabidopsis.

In Figure 5.2 we show ROC curves for all predictors on the Human and
Arabidopsis data but it is important to remember that in this context
the low false positive regime is especially important. This is because
of the extremely low frequency of true positives in the data (less than
1%). This is explored further in Figure 5.3 but for now it is important
to note that ampscanv2 is not shown in Figure 5.3 because its ROC curve
does not extend into this important regime despite the fact that it
otherwise appears to perform very well. Ampep and ampir\_mature both
perform very poorly reflecting the emphasis of their training data on
mature peptides rather than precursor proteins.

In order to properly capture the real-world performance of predictors on
genome scans it is important to use a plot that emphasises the absolute
numbers of true and false positives. On this measure (shown in Figure
5.3) it can be seen that genome-wide prediction of AMPs is still an
imperfectly solved problem. Although the ampir precursor model clearly
performs far better than any other predictor, none were able to predict
more than 50% of true AMPs while controlling false positives to under
500. Nevertheless, given the difficulties in identifying AMPs and the
importance of this task this level of enrichment is of great practical
use, reducing the number of false experimental leads per true positive
from many thousands down to tens or hundreds.

![](05_benchmark_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->
**Figure 5.3:** Performance of `ampir` compared with three existing AMP
prediction models iAMPpred (Meher et al., 2017), AmPEP (Bhadra et al.,
2018), AMP Scanner (Veltri et al., 2018). Results for iAMPpred are not
shown for parts A and B because it was impractical to run on large
numbers of sequences. Parts A and B are scaled so that the limits of the
y-axis show the full complement of known AMPs in each genome (291 for
Arabidopsis, 101 for Human), and the limits of the x-axis are restricted
to emphasise behaviour in the low false positive (FP) regime (FP \< 500)
because this is most relevant in whole genome scans. Part C is a
receiver operating characteristic (ROC) curve based on the ampir
reserved testing data. It shows FPR (False Positive Rate) versus Recall
(True Positive Rate).
