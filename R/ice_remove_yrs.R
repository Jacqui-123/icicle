

#' Remove years with more than 14 consecutive NA values for flow
#'
#' @param data A data frame
#'
#' @return  Data frame without years that have 14 or more NA values for flow
#' @export
#'
#' @examples
ice_remove_yrs <- function(data) {

  na_rows <- with(rle(is.na({{data}}$Value)), rep(values & lengths > 14, lengths))
  yearstoremove <- unique({{data}}$waterYear[na_rows])
  output <- {{data}}[!{{data}}$waterYear %in% yearstoremove, ]
  return(output)
}
