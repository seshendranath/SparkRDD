lambdarize <- function(rdd_func) function(rdd, ...) rdd_func(rdd, lambda(...))

#'
#' @export
filterRDD_ <- lambdarize(SparkR:::filterRDD)

#'
#' @export
map_ <- lambdarize(SparkR:::map)

#'
#' @export
reduce_ <- lambdarize(SparkR:::reduce)

#'
#' @export
flatMap_ <- lambdarize(SparkR:::flatMap)

#'
#' @export
reduceByKey_ <- function(rdd, ..., numPartitions) SparkR:::reduceByKey(rdd, lambda(...), numPartitions)
