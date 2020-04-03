Feature selection
================

## Recursive feature elimination (RFE)

Features were primarily chosen by examining the literature. However, as
feature selection is a significant part of statistical learning, RFE
analysis was used to examine the features used to train the rSVM model.

``` r
svmProfile <- rfe(features[,2:45],
                  features[,46],
                  rfeControl = rfeControl(functions = caretFuncs,method = "repeatedcv", number = 10, repeats = 3),
                  method = "svmRadial",
                  preProcess = c("center", "scale"))
```

Read RFE results rfe.rds was obtained from running the `rfe.R` and
`rfe.sh` scripts on the HPC using identical code that would create the
`svmProfile` variable as shown above.

``` r
svmProfile <- readRDS("cache/rfe.rds")
```

Rank important features

``` r
varImp(svmProfile)
```
