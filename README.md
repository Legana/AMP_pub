
# ampir <a href='https://github.com/Legana/ampir'><img src="figures/ampir_hex.png" width="90" align="right" height="100" /></a>

# AMP prediction

This repository contains code used for the
[ampir](https://github.com/Legana/ampir) R package paper

  - [Build positive dataset](01_collate_databases.md) : Rmd file
    [01\_collate\_databases.Rmd](01_collate_databases.Rmd)
  - [Calculate features](02_train_test_set.md) : Rmd file
    [02\_train\_test\_set.Rmd](02_train_test_set.Rmd)
  - [Feature selection analysis](03_feature_selection.md) : Rmd file
    [03\_feature\_selection.Rmd](03_feature_selection.Rmd)
  - [Reads and tests tuned model](04_tune_model.md) : Rmd file
    [04\_tune\_model.Rmd](04_tune_model.Rmd)
  - [Benchmarks `ampir` to other predictors](05_benchmark_auroc.md) :
    Rmd file [05\_benchmark\_auroc.Rmd](05_benchmark_auroc.Rmd)
  - [Creates precision-recall curve](06_alpha_prcurve.md) : Rmd file
    [06\_alpha\_prcurve.Rmd](06_alpha_prcurve.Rmd)

The files required to run the code in these Rmd files can be obtained
[here](https://cloudstor.aarnet.edu.au/plus/s/e2MsuyZPwZOOuBe/download?path=%2F&files=data.tgz)
or by using the
command:

``` bash
wget 'https://cloudstor.aarnet.edu.au/plus/s/e2MsuyZPwZOOuBe/download?path=%2F&files=data.tgz' -O data.tgz
tar -zxvf data.tgz 
```
