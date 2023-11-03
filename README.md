
# ampir <a href='https://github.com/Legana/ampir'><img src="figures/ampir_hex.png" width="90" align="right" height="100" /></a>

# AMP prediction

This repository contains code used for the
[ampir](https://github.com/Legana/ampir) R package paper published in
the *Bioinformatics* journal as
[btaa653](https://academic.oup.com/bioinformatics/article-abstract/doi/10.1093/bioinformatics/btaa653/5873588)

-   [Collate data](01_collate_databases.md) : Rmd file
    [01_collate_databases.Rmd](01_collate_databases.Rmd)

-   [Build training sets](02_build_training_data.md) : Rmd file
    [02_build_training_data.Rmd](02_build_training_data.Rmd)

-   [Feature selection analysis](03_feature_selection.md) : Rmd file
    [03_feature_selection.Rmd](03_feature_selection.Rmd)

-   [Model tuning](04_tune_model.md) : Rmd file
    [04_tune_model.Rmd](04_tune_model.Rmd)

-   [Benchmarking](05_benchmark.md) : Rmd file
    [05_benchmark.Rmd](05_benchmark.Rmd)

-   [Case studies](06_case_studies.md) : Rmd file
    [06_case_studies.Rmd](06_case_studies.Rmd)

-   [Test ampir_v1.1.0](test_models.md) : Rmd file
    [test_models.Rmd](test_models.Rmd)

The files required to run the code in these Rmd files can be obtained
[here](http://data.qld.edu.au/public/Q5999/Legana/AMP_pub/data.tgz) or by
using the command:

``` bash
wget 'http://data.qld.edu.au/public/Q5999/Legana/AMP_pub/data.tgz' -O data.tgz
tar -zxvf data.tgz 
```

### `sessionInfo()`

    R version 4.1.2 (2021-11-01)
    Platform: x86_64-apple-darwin17.0 (64-bit)
    Running under: macOS Monterey 12.3.1

    Matrix products: default
    LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib

    locale:
    [1] en_AU.UTF-8/en_AU.UTF-8/en_AU.UTF-8/C/en_AU.UTF-8/en_AU.UTF-8

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    other attached packages:
     [1] pROC_1.18.0     ampir_1.1.0     cowplot_1.1.1   ggpubr_0.4.0    forcats_0.5.1   stringr_1.4.0  
     [7] dplyr_1.0.7     purrr_0.3.4     readr_2.1.1     tidyr_1.1.4     tibble_3.1.6    tidyverse_1.3.1
    [13] caret_6.0-90    lattice_0.20-45 ggplot2_3.3.5  

    loaded via a namespace (and not attached):
     [1] nlme_3.1-153         fs_1.5.2             lubridate_1.8.0      httr_1.4.2           tools_4.1.2         
     [6] backports_1.4.1      utf8_1.2.2           R6_2.5.1             rpart_4.1-15         DBI_1.1.2           
    [11] colorspace_2.0-2     nnet_7.3-16          withr_2.4.3          tidyselect_1.1.1     compiler_4.1.2      
    [16] cli_3.1.0            rvest_1.0.2          xml2_1.3.3           labeling_0.4.2       scales_1.1.1        
    [21] Peptides_2.4.4       digest_0.6.29        rmarkdown_2.13       pkgconfig_2.0.3      htmltools_0.5.2     
    [26] parallelly_1.30.0    dbplyr_2.1.1         fastmap_1.1.0        rlang_0.4.12         readxl_1.3.1        
    [31] rstudioapi_0.13      farver_2.1.0         generics_0.1.1       jsonlite_1.7.2       ModelMetrics_1.2.2.2
    [36] car_3.0-12           magrittr_2.0.1       Matrix_1.3-4         Rcpp_1.0.8           munsell_0.5.0       
    [41] fansi_1.0.2          abind_1.4-5          lifecycle_1.0.1      stringi_1.7.6        yaml_2.2.1          
    [46] carData_3.0-5        MASS_7.3-54          plyr_1.8.6           recipes_0.1.17       grid_4.1.2          
    [51] parallel_4.1.2       listenv_0.8.0        crayon_1.4.2         haven_2.4.3          splines_4.1.2       
    [56] hms_1.1.1            knitr_1.37           pillar_1.6.4         ggsignif_0.6.3       future.apply_1.8.1  
    [61] reshape2_1.4.4       codetools_0.2-18     stats4_4.1.2         reprex_2.0.1         glue_1.6.0          
    [66] evaluate_0.14        data.table_1.14.2    modelr_0.1.8         vctrs_0.3.8          tzdb_0.2.0          
    [71] foreach_1.5.1        cellranger_1.1.0     gtable_0.3.0         future_1.23.0        assertthat_0.2.1    
    [76] xfun_0.30            gower_0.2.2          prodlim_2019.11.13   broom_0.7.11         rstatix_0.7.0       
    [81] class_7.3-19         survival_3.2-13      timeDate_3043.102    iterators_1.0.13     lava_1.6.10         
    [86] globals_0.14.0       ellipsis_0.3.2       ipred_0.9-12      
