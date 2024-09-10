


#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
calc_rle_yrs <- function(data) {
  #function to remove years that have > 3 consecutive NA values (ie 3 days in a row with no data)
  #and return the original df, without the offending years
  na_rows <- with(rle(is.na({{data}}$Value)), rep(values & lengths > 3, lengths))
  years_to_remove <- unique({{data}}$waterYear[na_rows])
  output <- {{data}}[!{{data}}$waterYear %in% years_to_remove, ]
  return(output)
}
