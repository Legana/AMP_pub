library(R.utils)
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)

if(is.null(args$outfile)){
  stop("Must specify an outfile")
}

if(is.null(args$target)){
  stop("Must specify a target database")
}

if(is.null(args$background)){
  stop("Must specify a background database")
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
library(ampir)


set.seed(396)

# read target and background data
# it is the users responsibility to ensure these are read for model building ie;
#   - free of nonstandard aa's
#   - balanced appropriately
#   - free of very small peptides (<20aa)
#
tg <- read_faa(args$target)
tg$Label <- "Tg"
bg <- read_faa(args$background)
bg$Label <- "Bg"
bg_tg <- rbind(bg, tg)


#calculate features
features <- ampir:::calculate_features(bg_tg)
features$Label <- as.factor(bg_tg$Label)


#split feature set data 80/20 and create train and test set
trainIndex <-createDataPartition(y=features$Label, p=.8, list = FALSE)
featuresTrain <-features[trainIndex,]
featuresTest <-features[-trainIndex,]

#resample method using repeated cross validation and adding in a probability calculation
trctrl_prob <- trainControl(method = "repeatedcv", number = 10, repeats = 3, classProbs = TRUE)

# Tune the Model
# We determine optimal values for sigma and C by training and testing models over a grid of values
# Each model train/test can be run separately so this is trivially parallelisable
# Set ncores on the command-line to run in parallel

library(doParallel)
cl <- makePSOCKcluster(args$ncores)
registerDoParallel(cl)

grid_for_final_svmradial <- expand.grid(sigma=c(0.01,0.02,0.05,0.07,0.1,0.15,0.2,0.5), C=c(0.5,1,2,4,8,16))

svm_Radial_final <- train(Label~.,
                            data = featuresTrain[,-c(1)], #without names and lamda values
                            method="svmRadial",
                            trControl = trctrl_prob,
                            preProcess = c("center", "scale"),
                            tuneGrid = grid_for_final_svmradial)

saveRDS(svm_Radial_final,args$outfile)

