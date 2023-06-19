
ice_group_1 <- function(data) {

  lst <- list()

  for (i in unique({{data}}$waterYear)) {

    length_B_date  <- max(rle({{data}}$Symbol[{{data}}$waterYear == i] == "B")[[1]])
    length_B_date <- length_B_date - 1
    lst[[i]] <- length_B_date
  }

  Ice_coverage_wy <- data.frame(waterYear = names(lst), Ice_coverage_wy = unlist(lst))
  rownames(Ice_coverage_wy) <-NULL

  return(Ice_coverage_wy)

}
