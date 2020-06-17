library(R.utils)
library(ampir)

args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)

if(is.null(args$infile)){
  stop("Must specify an input file")
}


system.time(indf <- read_faa(args$infile))

for(nc in c(32,16,8,4,2,1)){
  cat("Running with ",nc," cores")
  st <- system.time(predict_amps(indf,n_cores=nc))
  print(st)
}


