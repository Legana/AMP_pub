Precision-recall curve
================

``` r
library(tidyverse)
library(patchwork)
source("R/calc_cm_metrics.R")
```

``` r
ampir_prob_data <- readRDS("ampir_0.1.0_data/ampir_prob_data.rds")
```

``` r
ampir_roc_data <- as.data.frame(t(sapply(seq(0.01, 0.99, 0.01), calc_cm_metrics, ampir_prob_data)))
```

## Theoretical AMP content

A new variable, \(\alpha\), was introduced to represent the percentage
of AMPs in the test set to more easily create precision-recall curves
for various AMP proportions. The calculation for the recall metric for
\(\alpha\) remains the same but the precision metric has been slightly
modified (see below):

\[Precision_{\alpha} = \frac{TP\alpha}{TP\alpha + FP(1-\alpha)}\]

\[Recall_{\alpha} = \frac{TP}{TP + FN}\]

Function that uses the recall-precision metric calculations for any
\(alpha\) value

``` r
calc_precision_recall <- function(df,alpha) {
  df %>% 
  mutate(Recall = Recall) %>% 
  mutate(Precision = TP*alpha / (TP*alpha+FP*(1-alpha))) %>% 
  select(Recall,Precision,p_threshold)
}
```

Use the function for a range of \(alpha\) values and collapse to data
frame

``` r
pr_data <- do.call(rbind,lapply(c(0.01,0.05,0.1,0.5),function(alpha) {
  calc_precision_recall(ampir_roc_data,alpha) %>% add_column(alpha=alpha)
}))
```

Plot an explicit axis for `p_threshold`. This is useful for choosing the
threshold value. Also note that as \(\alpha\) gets smaller and smaller
the Precision curve shifts so that high values of precision are only
achieved for very high `p_threshold` values.

``` r
pr_data_long <- pr_data %>% gather("metric","value",-p_threshold,-alpha)


variable_names <- c("0.01" = "Proportion of AMPs in genome: 0.01",
                    "0.05" = "Proportion of AMPs in genome: 0.05",
                    "0.1" = "Proportion of AMPs in genome: 0.10",
                    "0.5" = "Proportion of AMPs in genome: 0.50")
```

``` r
ggplot(pr_data_long,aes(x=p_threshold,y=value)) + 
  geom_line(aes(linetype=metric)) + facet_wrap(~alpha, labeller= as_labeller(variable_names)) +
  labs(x = "Probability threshold", y = "", linetype = "") +
  scale_x_continuous(breaks=c(0, 0.50, 1.00)) +
  scale_y_continuous(breaks=c(0, 0.50, 1.00)) +
  theme(legend.position = "left",
        legend.text = element_text(angle = 90, hjust = 0.5),
        legend.margin = margin(0,0,0,8),
        legend.box.margin=margin(-10,-10,-10,-10),
        legend.key = element_rect(fill = "white"),
        legend.key.height = unit(2, "cm"),
        legend.box.spacing = unit(0.1, "cm"),
        panel.background = element_blank(),
        axis.line = element_line(colour = "grey")) +
  guides(linetype = guide_legend(reverse=TRUE))
```

``` r
ggsave("figures/alphas.png", width = 7, height=5)
```

Extract 1% alpha
value

``` r
pr_data_alpha1_long <- pr_data_long %>% filter(alpha == 0.01)
```

``` r
ggplot(filter(pr_data_alpha1_long, p_threshold >= 0.5), aes(x=p_threshold, y=value)) + 
  geom_line(aes(colour = metric)) + 
  labs(x = "Probability threshold", y = "", colour = "") +
  scale_colour_manual(values = c("blueviolet", "forestgreen")) +
  scale_x_continuous(breaks=c(0.50, 0.60, 0.70, 0.80, 0.90, 1.00)) +
  scale_y_continuous(breaks=c(0.10, 0.50, 1.00)) +
  theme(legend.position = c(0.2, 0.5),
        panel.background = element_blank(),
        legend.key=element_blank(),
        axis.line = element_line(colour = "grey")) +
  guides(colour = guide_legend(reverse = TRUE))
```

``` r
#for bioinformatics paper, black and white and figure must be .tif and high resolution (1200 dpi for line drawing 350 d.p.i. for colour and half-tone artwork) https://academic.oup.com/bioinformatics/pages/instructions_for_authors

alpha1 <- ggplot(filter(pr_data_alpha1_long, p_threshold >= 0.5), aes(x=p_threshold, y=value)) + 
  geom_line(aes(colour = metric)) + 
  labs(x = "Probability threshold", y = "", colour = "") +
  scale_colour_manual(values = c("blueviolet", "forestgreen")) +
  scale_x_continuous(breaks=c(0.50, 0.60, 0.70, 0.80, 0.90, 1.00)) +
  theme(legend.position = c(0.2, 0.5),
        panel.background = element_blank(),
        legend.key=element_blank(),
        axis.line = element_line(colour = "grey")) +
  guides(colour = guide_legend(reverse = TRUE)) +
  ggtitle("B")
```

# From benchmark\_auroc.Rmd

``` r
benchmark_roc <- ggplot(models_roc) + 
  geom_line(aes(x = FPR, y = TPR, colour = model)) + 
  xlim(0,1) +
  labs(x = "False positive rate", y = "True positive rate", colour = "Model and AUC") +
  scale_colour_manual(breaks= c("ampir", "amp_scanner", "ampep", "iamppred"),
                      labels=c("ampir - 96%", "amp scanner - 86%", "ampep - 67%", "iamppred - 58%"),
                      values = c("blueviolet", "goldenrod2", "blue4", "cyan")) +
  theme(legend.position = c(0.76, 0.25),
        legend.key=element_blank(),
        legend.title = element_text(size = 8),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "grey")) +
  ggtitle("A")
```

Combine the plots for ampir paper

``` r
benchmark_roc | alpha1
roc_and_alpha1 <- benchmark_roc | alpha1
```

``` r
ggsave("figures/roc_and_alpha1.jpg", roc_and_alpha1, width = 7, height=4)
```
