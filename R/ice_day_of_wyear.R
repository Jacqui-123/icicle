


#' Calculate the day of the water year
#'
#' @param  Data data frame used to calculate the day of the year
#' @param  year_column column of year values in the dataframe
#'
#' @return A data frame
#' @export
#'
#' @examples
ice_day_of_wyear <- function(data, year_column = "waterYear"){
  #function sequences by number of days in each water year
  df <- data.frame()
  for (i in unique({{data}}[[year_column]])) {
    df_subset <- {{data}}[{{data}}[[year_column]] == i, ]
    days <- seq(1:nrow(df_subset))
    df_subset$day_of_year <- days
    df <- rbind(df, df_subset)
  }

  return(df)
}
