#function_to_calculate_cm_stats

calc_cm_metrics <- function(p_threshold, df) {
  
  TP <- df %>% filter((actual=="Tg")) %>% filter(Tg > p_threshold) %>% n_distinct()
  FP <- df %>% filter((actual=="Bg")) %>% filter(Tg > p_threshold) %>% n_distinct()
  TN <- df %>% filter((actual=="Bg")) %>% filter(Tg < p_threshold) %>% n_distinct()
  FN <- df %>% filter((actual=="Tg")) %>% filter(Tg < p_threshold) %>% n_distinct()
  
  Specificity <- round(TN / (TN + FP), digits = 3) #aka TNR
  Recall <- round(TP / (TP + FN), digits = 3) # aka sensitivity, TPR
  Precision <- round(TP/ (TP + FP), digits = 3) # positive predictive value
  FPR <- FP / (TN + FP)
  
  cm <- c(TP, FP, TN, FN, Specificity, Recall, Precision, FPR, p_threshold)
  names(cm) <-c("TP", "FP", "TN", "FN", "Specificity", "Recall", "Precision", "FPR", "p_threshold") 
  cm
}