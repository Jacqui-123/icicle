
NOTE: This package is under development, and a few functions are
undergoing a re-write. Additionally, more complete documentation and
test cases are in progress.

<!-- README.md is generated from README.Rmd. Please edit that file -->

# icicle

<!-- badges: start -->
<!-- badges: end -->

The goal of icicle is to calculate and tidy ice cycle variables from
flow data collected by the Water Survey of Canada. This package provides
a set of functions that calculate the freeze/thaw dates, onset of
freshet, and length of continuous ice coverage for each year. Additional
tidying functions remove years from the dataframe with consecutive NA
values, and add a column of “day of the year”, or Julian dates.

## Installation

You can install the development version of icicle from
[GitHub](https://github.com/) with:

``` r
#install.packages("devtools")
devtools::install_github("Jacqui-123/icicle")
```

## Example

This is a basic example of how you might use the functions in this
package:

``` r
library(icicle)
## tbd example 
```
