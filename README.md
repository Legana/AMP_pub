
# ampir <a href='https://github.com/Legana/ampir'><img src="figures/ampir_hex.png" width="90" align="right" height="100" /></a>

# AMP prediction

This repository contains code used for the
[ampir](https://github.com/Legana/ampir) R package paper published in
the *Bioinformatics* journal as
[btaa653](https://academic.oup.com/bioinformatics/article-abstract/doi/10.1093/bioinformatics/btaa653/5873588)

  - [Collate data](01_collate_databases.md) : Rmd file
    [01\_collate\_databases.Rmd](01_collate_databases.Rmd)
  - [Build training sets](02_build_training_data.md) : Rmd file
    [02\_build\_training\_data.Rmd](02_build_training_data.Rmd)
  - [Feature selection analysis](03_feature_selection.md) : Rmd file
    [03\_feature\_selection.Rmd](03_feature_selection.Rmd)
  - [Model tuning](04_tune_model.md) : Rmd file
    [04\_tune\_model.Rmd](04_tune_model.Rmd)
  - [Benchmarking](05_benchmark.md) : Rmd file
    [05\_benchmark.Rmd](05_benchmark.Rmd)
  - [Case studies](06_case_studies.md) : Rmd file
    [06\_case\_studies.Rmd](06_case_studies.Rmd)

The files required to run the code in these Rmd files can be obtained
[here](https://cloudstor.aarnet.edu.au/plus/s/qha2IliJ8flTrWY) or by
using the
command:

``` bash
wget 'https://cloudstor.aarnet.edu.au/plus/s/qha2IliJ8flTrWY/download' -O data.tgz
tar -zxvf data.tgz 
```
