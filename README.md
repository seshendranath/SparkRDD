# SparkRDD - SparkR extension for using Spark RDD
Koji MAKIYAMA (@hoxo_m)  



## Quick Start

[Quick Start - Spark 1.4.0 Documentation](https://spark.apache.org/docs/latest/quick-start.html)

### Create Spark Context


```r
library(SparkRDD)
suppressMessages(sc <- sparkR.init(master="local"))
```

```
## Launching java with spark-submit command /home/makiyama/bin/spark/bin/spark-submit  sparkr-shell /tmp/RtmpMtiiEB/backend_port6a1c20793bed
```

### Basics


```r
file <- file.path(Sys.getenv("SPARK_HOME"), "README.md")
textFile <- sc %>% textFile(file) 

textFile %>% count
```

```
## [1] 98
```


```r
textFile %>% first
```

```
## [1] "# Apache Spark"
```


```r
lineWithSpark <- textFile %>% 
  filterRDD_(line: grepl("Spark", line))

lineWithSpark %>% count
```

```
## [1] 19
```

### More on RDD Operations


```r
textFile %>% 
  map_(line: length(strsplit(line, " ")[[1]])) %>%
  reduce_(a, b: ifelse(a > b, a, b))
```

```
## [1] 14
```


```r
textFile %>% 
  map_(line: length(strsplit(line, " ")[[1]])) %>%
  reduce_(max)
```

```
## [1] 14
```


```r
wordCounts <- textFile %>% 
  flatMap_(line: strsplit(line, " ")[[1]]) %>%
  map_(word: list(word, 1)) %>%
  reduceByKey_(a, b: a + b, numPartitions=1)

wordCounts %>% collect %>% 
  Map_(x: data.frame(word=x[[1]], count=x[[2]])) %>%
  Reduce_(rbind) %>%
  head
```

```
##             word count
## 1       programs     2
## 2         online     1
## 3   Thriftserver     1
## 4        against     1
## 5 Alternatively,     1
## 6        Running     1
```

### Stop


```r
sparkR.stop()
```

