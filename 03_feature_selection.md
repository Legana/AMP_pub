Feature selection
================

## Feature distributions

As an indication of features that are likely to be useful for
classification we plot their distributions for background and target.

``` r
features_tg_bg_1 <- read_rds("cache/features_1.rds")

features_bg_tg_1_long <- features_tg_bg_1 %>% gather(key = "Feature","Value",-seq_name,-Label)

ggplot(features_bg_tg_1_long,aes(x=Value)) + 
  geom_density(aes(color=Label)) + 
  facet_wrap(~Feature, scales = "free", ncol = 3)
```

![](03_feature_selection_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

## Correlated Predictors

Although a small number these predictors are correlated there are none
with near-perfect correlation (max cor ~ 0.8). We therefore did not
remove any features on the basis of correlation since this is unlikely
to negatively affect model performance.

``` r
featuresCM <- cor(features_tg_bg_1[,-c(1,46)])
summary(featuresCM[upper.tri(featuresCM)])
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -0.40505 -0.04645  0.12663  0.18086  0.36749  0.85533

## Recursive feature elimination (RFE)

RFE analysis was used to find an optimal subset of the features to be
included in the model. Since this is a computationally intensive process
it was performed using the `rfe.R` and `rfe.sh` scripts on an HPC
system. The resulting `rfe` outputs are provided in `cache/rfe_1.rds`
and show that the best performance can be obtained with 30 predictors.
The set of features also agrees with visual inspection of the feature
density plots as the selection includes those predictors that show clear
separation between target and background. This set of predictors was
used for subsequent model tuning and is encapsulated in the final model
included with the `ampir` package.

``` r
svmProfile <- readRDS("cache/rfe_1.rds")
trellis.par.set(caretTheme())
plot(svmProfile, type = c("g", "o"))
```

![](03_feature_selection_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
predictors(svmProfile)
```

    ##  [1] "Mw"             "Xc1.E"          "Xc1.L"          "Xc1.R"         
    ##  [5] "Xc1.I"          "Xc1.D"          "Xc1.V"          "Xc1.S"         
    ##  [9] "Xc1.T"          "Xc1.M"          "Xc1.Q"          "Xc1.P"         
    ## [13] "Xc1.A"          "Xc1.F"          "Xc1.H"          "Amphiphilicity"
    ## [17] "Xc1.Y"          "Xc1.K"          "Xc1.N"          "Xc1.G"         
    ## [21] "Xc2.lambda.2"   "Xc1.C"          "Xc1.W"          "Xc2.lambda.5"  
    ## [25] "Xc2.lambda.6"   "Xc2.lambda.3"   "Xc2.lambda.4"   "Xc2.lambda.1"  
    ## [29] "Hydrophobicity" "Xc2.lambda.8"   "Xc2.lambda.7"   "Charge"        
    ## [33] "Xc2.lambda.10"  "pI"             "Xc2.lambda.9"   "Xc2.lambda.17" 
    ## [37] "Xc2.lambda.11"  "Xc2.lambda.15"  "Xc2.lambda.18"  "Xc2.lambda.12"

``` r
write_rds(predictors(svmProfile),"cache/predictors_1.1.rds")
```

## Variable importance

``` r
varImp(svmProfile)
```

    ##                  Overall
    ## Mw             0.8556765
    ## Xc1.E          0.8508303
    ## Xc1.L          0.8298702
    ## Xc1.R          0.8175535
    ## Xc1.I          0.8163358
    ## Xc1.D          0.8108398
    ## Xc1.V          0.8042061
    ## Xc1.S          0.7853369
    ## Xc1.T          0.7776274
    ## Xc1.M          0.7756395
    ## Xc1.Q          0.7717201
    ## Xc1.P          0.7667631
    ## Xc1.A          0.7652335
    ## Xc1.F          0.7632497
    ## Xc1.H          0.7581777
    ## Amphiphilicity 0.7499673
    ## Xc1.Y          0.7483742
    ## Xc1.K          0.7415350
    ## Xc1.N          0.7388545
    ## Xc1.G          0.7236910
    ## Xc2.lambda.2   0.6753046
    ## Xc1.C          0.6742910
    ## Xc1.W          0.6594280
    ## Xc2.lambda.5   0.6419415
    ## Xc2.lambda.6   0.6396627
    ## Xc2.lambda.3   0.6377154
    ## Xc2.lambda.4   0.6367368
    ## Xc2.lambda.1   0.6334239
    ## Hydrophobicity 0.6198371
    ## Xc2.lambda.8   0.6038245
    ## Xc2.lambda.7   0.6010635
    ## Charge         0.5949514
    ## Xc2.lambda.10  0.5883212
    ## pI             0.5580306
    ## Xc2.lambda.9   0.5461869
    ## Xc2.lambda.17  0.5364994
    ## Xc2.lambda.11  0.5313319
    ## Xc2.lambda.15  0.5221101
    ## Xc2.lambda.18  0.5168897
    ## Xc2.lambda.12  0.5156498
    ## Xc2.lambda.14  0.5155397
    ## Xc2.lambda.19  0.5152833
    ## Xc2.lambda.13  0.5135925
    ## Xc2.lambda.16  0.5120653
