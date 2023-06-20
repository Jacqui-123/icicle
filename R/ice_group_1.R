
#' Calculate total continuous ice coverage per year
#'
#' @param data data frame used to calculate ice cover
#'
#' @return A data frame.
#' @export
#'
#' @examples
ice_group_1 <- function(data, year_column = "waterYear") {
  lst <- list()
  for (i in unique({{data}}[[year_column]])) {
    length_B_date  <- max(rle({{data}}$Symbol[{{data}}[[year_column]] == i] == "B")[[1]])
    length_B_date <- length_B_date - 1
    lst[[i]] <- length_B_date
  }

  Ice_coverage <- data.frame(Year = names(lst), Ice_coverage = unlist(lst))
  rownames(Ice_coverage) <-NULL

  return(Ice_coverage)

}
