library(R.utils)
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)

if(is.null(args$outfile)){
  stop("Must specify an outfile")
}

if(is.null(args$train)){
  stop("Must specify a training dataset")
}

if(is.null(args$ncores)){
  args$ncores=1
} else {
  args$ncores <- as.integer(args$ncores)
  if(is.na(args$ncores) || args$ncores < 0){
    stop("Invalid core count provided")
  }
}


# if(is.null(args$bgweight)){
#   args$bgweight=c(0.5,0.5)
# } else {
#   args$bgweight <- as.integer(args$bgweight)
#   if(is.na(args$bgweight) || args$bgweight < 0){
#     stop("Invalid core count provided")
#   }
# }


library(caret)

set.seed(396)

# read feature data

featuresTrain <- readRDS(args$train)

model_weights <- ifelse(featuresTrain$Label == "Tg",
                        (1/table(featuresTrain$Label)[1]) * 0.5,
                        (1/table(featuresTrain$Label)[2]) * 0.5)




#resample method using repeated cross validation and adding in a probability calculation
trctrl_prob <- trainControl(method = "repeatedcv", number = 10, repeats = 3, classProbs = TRUE)

# Tune the Model
# We determine optimal values for sigma and C by training and testing models over a grid of values
# Each model train/test can be run separately so this is trivially parallelisable
# Set ncores on the command-line to run in parallel

library(doParallel)
cl <- makePSOCKcluster(args$ncores)
registerDoParallel(cl)

grid_for_final_svmradial <- expand.grid(sigma=c(0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.10,0.2,0.3,0.5), C=c(0.5,1,2,3,4,5,6,7,8,9,10))

svm_Radial_final <- train(Label~.,
                            data = featuresTrain[,c(2:28,46)],
                            method="svmRadial",
                            trControl = trctrl_prob,
                            preProcess = c("center", "scale"),
                            weights = model_weights,
                            tuneGrid = grid_for_final_svmradial)

saveRDS(svm_Radial_final,args$outfile)


