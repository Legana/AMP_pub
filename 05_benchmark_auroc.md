Benchmark AUROC curve
================

Four well performing AMP predictors were chosen to compare `ampir`’s
perfomance to (see Table
1)

##### Table 1: AMP predictors with their papers and model accessiblity

| AMP predictor name | Reference                                                           | Availability                                                                          |
| ------------------ | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| AMP scanner v2     | [Veltri et al. 2018](https://doi.org/10.1093/bioinformatics/bty179) | [amp scanner webserver](https://www.dveltri.com/ascan/v2/ascan.html)                  |
| amPEP              | [Bhadra et al. 2018](https://doi.org/10.1038/s41598-018-19752-w)    | [MATLAB source code](https://sourceforge.net/projects/axpep/files/AmPEP_MATLAB_code/) |
| iAMPpred           | [Meher et al. 2017](https://doi.org/10.1038/srep42362)              | [iAMPpred webserver](http://cabgrid.res.in:8080/amppred/)                             |
| iAMP-2L            | [Xiao et al. 2013](https://doi.org/10.1016/j.ab.2013.01.019)        | [iAMP-2L web server](http://www.jci-bioinfo.cn/iAMP-2L)                               |

\*`iAMP-2L` could not be included in the ROC curve as the model output
is binary only

To contrast the performance of `ampir` to other AMP predictors, a subset
of 1000 sequences from `ampir`’s test set was used to test each AMP
predictor. These 1000 sequences (500 positives and 500 negatives) were
not included in `ampir`’s trained model.

AMP predictors were accessed in ***November 2019***

*Data have to be updated*

## Data

Read in `ampir`’s trained rSVM model and associated data used:

  - Positive and negative dataset
  - Calculated features from the the positive and negative dataset
  - Training set (80% from the calculated feature dataset)
  - Testing set (20% from the calculated feature dataset)

<!-- end list -->

``` r
svm_Radial98_final <- readRDS("ampir_0.1.0_data/svm_Radial98_final.rds")

bg_tg98 <- readRDS("ampir_0.1.0_data/bg_tg98.rds")

features98 <- readRDS("ampir_0.1.0_data/features98.rds")

featuresTest98Nov19 <- readRDS("ampir_0.1.0_data/features98TestNov19.rds")
featuresTrain98Nov19 <- readRDS("ampir_0.1.0_data/features98TrainNov19.rds")
```

Subset ampir’s test set to 1000 sequence feature calculations and match
back to positive-negative dataset to obtain the subset test set in FASTA
format

``` r
testIndex1 <-createDataPartition(y=featuresTest98Nov19$Label, p=.502, list = FALSE)
featuresTest98_1000 <- featuresTest98Nov19[testIndex1,]


test_1000 <- bg_tg98[bg_tg98$seq_name %in% featuresTest98_1000$seq_name,]
rownames(test_1000) <- NULL
```

Write subset test set as FASTA file

``` r
df_to_faa(test_1000[,-3], "ampir_0.1.0_data/1000_test_sqns98_new.fasta")
```

Split the 1000 sequences in half for use against `iamp2-L` as their web
server only takes 500 sequences at a time

``` r
test_500_bg <- filter(test_1000, Label == "Bg")
test_500_tg <- filter(test_1000, Label == "Tg")
```

Write the split subset as two FASTA files

``` r
df_to_faa(test_500_bg[,-3], "ampir_0.1.0_data/500_test_sqns98_bg.fasta")
df_to_faa(test_500_tg[,-3], "ampir_0.1.0_data/500_test_sqns98_tg.fasta")
```

### Test `ampir`

Use `ampir`’s entire test to calculate performance metrics of `ampir`
via a confusing matrix

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  Bg  Tg
    ##         Bg 922  97
    ##         Tg  74 899
    ##                                          
    ##                Accuracy : 0.9142         
    ##                  95% CI : (0.901, 0.9261)
    ##     No Information Rate : 0.5            
    ##     P-Value [Acc > NIR] : < 2e-16        
    ##                                          
    ##                   Kappa : 0.8283         
    ##                                          
    ##  Mcnemar's Test P-Value : 0.09249        
    ##                                          
    ##             Sensitivity : 0.9257         
    ##             Specificity : 0.9026         
    ##          Pos Pred Value : 0.9048         
    ##          Neg Pred Value : 0.9239         
    ##               Precision : 0.9048         
    ##                  Recall : 0.9257         
    ##                      F1 : 0.9151         
    ##              Prevalence : 0.5000         
    ##          Detection Rate : 0.4629         
    ##    Detection Prevalence : 0.5115         
    ##       Balanced Accuracy : 0.9142         
    ##                                          
    ##        'Positive' Class : Bg             
    ## 

Get the probability values of each prediction to be a
background/negative (bg) protein or a target/positive (tg) protein

Save the predicted probabilities with the actual true values to use in
`alpha_prcurve.Rmd`

``` r
saveRDS(test_pred_full_prob, "cache/ampir_prob_data.rds")
```

Use the subset of 1000 proteins to:

  - calculate performance metrics of `ampir` via a confusion matrix
  - get the probability values of each prediction with an added column
    that displays the actual true values for each class
  - calculate performance metrics for a probability threshold required
    to generate a receiver operating characteristic (ROC) curve

<!-- end list -->

``` r
test_pred_1000 <- predict(svm_Radial98_final, featuresTest98_1000)
confusionMatrix(test_pred_1000, featuresTest98_1000$Label, mode = "everything")
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  Bg  Tg
    ##         Bg 468  50
    ##         Tg  32 450
    ##                                           
    ##                Accuracy : 0.918           
    ##                  95% CI : (0.8992, 0.9343)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : < 2e-16         
    ##                                           
    ##                   Kappa : 0.836           
    ##                                           
    ##  Mcnemar's Test P-Value : 0.06047         
    ##                                           
    ##             Sensitivity : 0.9360          
    ##             Specificity : 0.9000          
    ##          Pos Pred Value : 0.9035          
    ##          Neg Pred Value : 0.9336          
    ##               Precision : 0.9035          
    ##                  Recall : 0.9360          
    ##                      F1 : 0.9194          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.4680          
    ##    Detection Prevalence : 0.5180          
    ##       Balanced Accuracy : 0.9180          
    ##                                           
    ##        'Positive' Class : Bg              
    ## 

``` r
ampir_1000 <- predict(svm_Radial98_final, featuresTest98_1000, type = "prob")
ampir_1000$actual <- featuresTest98_1000$Label

ampir_roc_1000 <- as.data.frame(t(sapply(seq(0.01, 0.99, 0.01), calc_cm_metrics, ampir_1000))) %>%
  add_column(model = "ampir")
```

### Test other AMP predictors

Read in the predictions from the 1000 sequence test set from each AMP
predictor (`ampscanner`, `amPEP`, `iampPRED`, `iAMP2-L`) obtained from
their respective models using their web servers or source code (see
Table 1), and calculate metrics required to generate a ROC
curve.

#### `ampscanner`

``` r
amp_scanner1000_results <- read.csv("raw_data/amp_scannerresultsNov19.csv")

amp_scanner1000_results <- amp_scanner1000_results %>%
  rename("Tg" = "Prediction_Probability") %>%
  mutate(Bg = 1 - Tg) %>%
  add_column(actual = featuresTest98_1000$Label) %>%
  select(Bg, Tg, actual)

amp_scanner_roc  <- as.data.frame(t(sapply(seq(0.01, 0.99, 0.01), calc_cm_metrics, amp_scanner1000_results))) %>%
  add_column(model = "amp_scanner")
```

#### `amPEP`

``` r
ampep_1000_results <- read.csv("raw_data/ampepresultsNov19.csv")

ampep_1000_results <- ampep_1000_results %>%
  rename("Tg" = "score") %>%
  mutate(Bg = 1 - Tg) %>%
  add_column(actual = featuresTest98_1000$Label) %>%
  select(Bg, Tg, actual)

ampep_1000_roc <- as.data.frame(t(sapply(seq(0.01, 0.99, 0.01), calc_cm_metrics, ampep_1000_results))) %>%
  add_column(model = "amPEP")
```

#### `iAMPpred`

``` r
amppred_1000 <- read.csv("raw_data/iamppredresults.csv")

amppred_1000 <- amppred_1000[,-1]

amppred_1000  <- amppred_1000 %>%
  mutate(Tg = rowMaxs(amppred_1000[2:4])) %>%
  mutate(Bg = 1 - Tg) %>%
  add_column(actual = featuresTest98_1000$Label) %>%
  select(Bg, Tg, actual)

amppred_1000_roc <- as.data.frame(t(sapply(seq(0.01, 0.99, 0.01), calc_cm_metrics, amppred_1000))) %>%
  add_column(model = "iAMPpred")
```

Combine the performance metrics for each
model

``` r
models_roc <- rbind(amp_scanner_roc, ampir_roc_1000, amppred_1000_roc, ampep_1000_roc)
```

Calculate the area under the receiver operating characteristics curve
(AUROC) for each model

``` r
roc(featuresTest98_1000$Label, ampir_1000$Tg) #0.9622 ampir

roc(featuresTest98_1000$Label, amp_scanner1000_results$Tg)  #0.8655 ampscanner

roc(featuresTest98_1000$Label, ampep_1000_results$Tg) #0.6707 ampep

roc(featuresTest98_1000$Label, amppred_1000$Tg)  #0.5856 iammpred
```

Plot the ROC for each model and display the AUROC

``` r
ggplot(models_roc) + 
  geom_line(aes(x = FPR, y = Recall, colour = model)) + 
  xlim(0,1) +
  labs(x = "False positive rate", y = "True positive rate") +
  scale_colour_manual(name= "Model and AUROC",
                      breaks= c("ampir", "amp_scanner", "amPEP", "iAMPpred"),
                      labels=c("ampir - 96%", "amp scanner - 86%", "amPEP - 67%", "iAMPpred - 58%"),
                      values = c("blueviolet", "goldenrod2", "blue4", "cyan")) +
  theme(legend.position = c(0.8, 0.31),
        legend.key = element_rect(fill = "white"),
        panel.background = element_blank(),
        axis.line = element_line(colour = "grey"))
```

![](05_benchmark_auroc_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->
