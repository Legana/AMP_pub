Model tuning
================

The default model included with ampir is an svm with radial kernel and
has two tuning parameters, sigma and C (cost). Optimal values for these
tuning parameters were obtained by using model tuning functions
available in `caret`. Since this is computationally intensive it was
performed on an HPC system. The R script `scripts/tune_model.R` provides
a convenient wrapper for the required functions and allows it to be run
easily on an HPC system.

This needs to be run on an HPC system with R installed and with packages
`caret`, `ampir`, `doParallel`, and `R.utils` installed

``` bash
module load R/3.6.1
Rscript tune_model.R outfile=../cache/tuned_precursor.rds train=../cache/featuresTrain_precursor.rds test=../cache/featuresTest_precursor.rds ncores=24
```

Inspecting the results reveals the variation of model performance with
the tuning parameters. If sigma is small and/or cost is small then the
model will be more ‘local’

![](04_tune_model_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

    ##     sigma C
    ## 103   0.1 3

    ##  [1] "Amphiphilicity" "Hydrophobicity" "pI"             "Mw"            
    ##  [5] "Charge"         "Xc1.A"          "Xc1.R"          "Xc1.N"         
    ##  [9] "Xc1.D"          "Xc1.C"          "Xc1.E"          "Xc1.Q"         
    ## [13] "Xc1.G"          "Xc1.H"          "Xc1.I"          "Xc1.L"         
    ## [17] "Xc1.K"          "Xc1.M"          "Xc1.F"          "Xc1.P"         
    ## [21] "Xc1.S"          "Xc1.T"          "Xc1.W"          "Xc1.Y"         
    ## [25] "Xc1.V"          "Xc2.lambda.1"   "Xc2.lambda.2"

To keep the final model size small for `ampir` distribution the training
is performed with optimal parameters one more time. This results in a
train object with all information required by ampir but without the
suboptimal models.
