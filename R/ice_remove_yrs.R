

#' Remove years with more than x consecutive NA values for flow
#'
#' @param data A data frame
#' @param value_column column of flow values in the dataframe
#' @param year_column column of year values in the dataframe
#' @param consecutive_nas non-zero integer
#'
#' @return  Data frame with the year(s) removed that have x or more consecutive NA values for flow
#' @export
#'
#' @examples
ice_remove_yrs <- function(data, value_column = "Value", year_column = "waterYear", consecutive_nas = 14) {
  #function to remove years that have > x consecutive NA for values column (ie 14 days in a row with no data)
  #and return the original df, without the years that have consecutive NAs

  na_rows <- with(rle(is.na({{data}}[[value_column]])), rep(values & lengths > {{consecutive_nas}}, lengths))
  years_to_remove <- unique({{data}}[[year_column]][na_rows])
  output <- {{data}}[!{{data}}[[year_column]] %in% years_to_remove, ]

  return(output)

}
