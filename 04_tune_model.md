Model tuning
================

## Data preparation

The training and test set were created in `02_train_test_set.Rmd` and
used for training the model that was trained and tuned with
`tune_model.R` and `tune_model.sh`.

``` r
featuresTest032020_98 <- readRDS("cache/featuresTest032020_98.rds")
featuresTest032020_98 <- readRDS("cache/featuresTest032020_98.rds")
```

## Running the tuning script

This needs to be run on an HPC system with R installed and with packages
`caret`, `ampir`, `doParallel`, and `R.utils` installed

``` bash
module load R/3.6.1
Rscript tune_model.R outfile=tuned.rds target=cache/positive032020_98.fasta background=cache/negative032020_98.fasta ncores=16
```

Or to run on the PBSPro batch system. Edit the tune\_model.sh script and
then submit using

``` bash
qsub tune_model.sh
```

## Read in tuned model

``` r
tuned_model <- readRDS("cache/tuned.rds")
```

The final values used for the model were sigma = 0.1 and C = 8.

*Retrain `ampir` model with these values to decrease model file size*

## Test model

Use model to classify proteins in the test set and calculation confusion
matrix

``` r
test_pred <- predict(tuned_model, featuresTest032020_98)
confusionMatrix(test_pred, featuresTest032020_98$Label, positive = "Tg", mode = "everything")
```

Use the probability scores from the model prediction and calculate the
AUROC

``` r
test_pred_prob <- predict(tuned_model, featuresTest032020_98, type = "prob")
roc(featuresTest032020_98$Label, test_pred_prob$Tg)
```
