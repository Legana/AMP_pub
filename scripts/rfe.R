library(R.utils)
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)

if(is.null(args$input)){
  stop("Must specify an input file")
}

if(is.null(args$outfile)){
  stop("Must specify an outfile")
}

if(is.null(args$ncores)){
  args$ncores=1
} else {
  args$ncores <- as.integer(args$ncores)
  if(is.na(args$ncores) || args$ncores < 0){
    stop("Invalid core count provided")
  }
}

library(caret)
library(doParallel)
cl <- makePSOCKcluster(args$ncores)
registerDoParallel(cl)

set.seed(396)

features <- readRDS(args$input)

rfe_control <- rfeControl(functions = caretFuncs, method = "repeatedcv", number = 10, repeats = 5, verbose = TRUE)

subsets <- c(1:5, 8, 10, 15, 20, 25, 30, 35, 40, 44)

svmProfile <- rfe(features[,2:45], features[,46], rfeControl = rfe_control,sizes=subsets,metric="Accuracy", method = "svmRadial", preProcess = c("center", "scale"))

saveRDS(svmProfile,args$outfile)
