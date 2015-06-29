.onAttach <- function(libname, pkgname) {
  if(!require(SparkR)) {
    warning("Failed to load 'SparkR' package. You must install it or export path to library.")
  } else if(packageVersion("SparkR") < 1.4) {
    warning(sprintf("Older version 'SparkR' %s found. Required version >= 1.4.0", packageVersion("SparkR")))
  }
  if(!require(lambdaR)) {
    if("devtools" %in% installed.packages()[, "Package"]) {
      devtools::install_github("hoxo-m/lambdaR")
    } else {
      warning("Failed to load 'lambdaR' package.\nIf you want to use lambda expressions, execute `devtools::install_github('hoxo-m/lambdaR')`")
    }
  } else if(packageVersion("lambdaR") < 2.0){
    if("devtools" %in% installed.packages()[, "Package"]) {
      devtools::install_github("hoxo-m/lambdaR")
    } else {
      warning(sprintf("Older version 'lambdaR' %s found. Required version >= 2.0.0.\nIf you want to use lambda expressions, execute `devtools::install_github('hoxo-m/lambdaR')`", packageVersion("SparkR")))
    }
  }
}

