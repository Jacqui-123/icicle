
#' Calculate total continuous ice coverage per year
#'
#' @param data input data used to calculate the ice variables
#' @param year_column column of year values in the dataframe
#'
#' @return A data frame with days of continuous ice coverage for each year
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
