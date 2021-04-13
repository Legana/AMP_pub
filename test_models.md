
# Test ampir v1.1 models

These models were trained in April 2021 with updated AMP sequences from
AMP databases and SwissProt (see
[01\_collate\_databases.md](01_collate_databases.md))

Read in trained models and test sets

``` r
ampir_mature <- readRDS("ampir_v1.1.0_data/tuned_mature.rds")
ampir_precursor <- readRDS("ampir_v1.1.0_data/tuned_precursor_imbal.rds")

mature_test <- readRDS("ampir_v1.1.0_data/v1.1_featuresTest_mature.rds")
precursor_test <- readRDS("ampir_v1.1.0_data/v1.1_featuresTest_precursor_imbal.rds")
```

Function to calculate metrics

``` r
calculate_model_metrics <- function(df) {
  
  
  TP <- df %>% filter((Label=="Tg")) %>% filter(Tg >= 0.5) %>% n_distinct() %>% as.numeric()
  FP <- df %>% filter((Label=="Bg")) %>% filter(Tg >= 0.5) %>% n_distinct() %>% as.numeric()
  TN <- df %>% filter((Label=="Bg")) %>% filter(Tg < 0.5) %>% n_distinct() %>% as.numeric()
  FN <- df %>% filter((Label=="Tg")) %>% filter(Tg < 0.5) %>% n_distinct() %>% as.numeric()
  #as.numeric was necessary for the MCC calculation 
  #as otherwise it would result in a "NAs produced by integer overflow" error.
  
  Specificity <- round(TN / (TN + FP), digits = 3) #aka TNR
  Accuracy <- round((TP + TN) / (TP + TN + FP + FN), digits = 3)  # all correct / all | (misclassification = 1-accuracy)
  Recall <- round(TP / (TP + FN), digits = 3) # aka sensitivity, TPR 
  Precision <- round(TP/ (TP + FP), digits = 3) # positive predictive value
  FPR <- round(FP / (TN + FP), digits = 3) # false positive rate
  F1 <- round((2 * Precision * Recall) / (Precision + Recall), digits = 3) # F1 score
  MCC <- round(((TP*TN) - (FP*FN)) / sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)), digits = 3) # Matthews correlation coefficient
  
  df1 <- data.frame(FPR, Accuracy, Specificity, Recall, Precision, F1, MCC)
  
  df2 <- evalmod(scores = df[["Tg"]], labels = df[["Label"]], mode = "rocprc") %>% 
    precrec::auc() %>% 
    select(curvetypes, aucs) %>% 
    pivot_wider(names_from = curvetypes, values_from = aucs) %>% 
    rename(AUROC = "ROC", AUPRC = "PRC") %>% 
    round(digits = 3)
  
  cbind(df1, df2)
  
}
```

``` r
ampir_mature_predict_and_actual <- predict(ampir_mature, mature_test, type = "prob") %>% add_column(Label = mature_test$Label)

ampir_precursor_predict_and_actual <- predict(ampir_precursor, precursor_test, type = "prob") %>% add_column(Label = precursor_test$Label)

mature_test_results <- calculate_model_metrics(ampir_mature_predict_and_actual)

precursor_test_results <- calculate_model_metrics(ampir_precursor_predict_and_actual)
```

Mature test results

|   FPR | Accuracy | Specificity | Recall | Precision |    F1 |   MCC | AUROC | AUPRC |
|------:|---------:|------------:|-------:|----------:|------:|------:|------:|------:|
| 0.145 |    0.862 |       0.855 |  0.869 |     0.856 | 0.862 | 0.725 | 0.926 | 0.926 |

Precursor test results

|   FPR | Accuracy | Specificity | Recall | Precision |    F1 |   MCC | AUROC | AUPRC |
|------:|---------:|------------:|-------:|----------:|------:|------:|------:|------:|
| 0.009 |    0.967 |       0.991 |   0.73 |     0.889 | 0.802 | 0.788 | 0.971 | 0.864 |
