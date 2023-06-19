


#' Calculate the day of the water year
#'
#' @param data Data frame used to calculate the day of water year
#'
#' @return A data frame
#' @export
#'
#' @examples
ice_day_of_wyear <- function(data){
  #function sequences by number of days in each water year

  df <- data.frame(waterYear = character(), sequence = character())

  for (i in unique({{data}}$waterYear)){
    df_subset <- {{data}}[{{data}}$waterYear == i,]
    days <- seq(1:nrow(df_subset))
    temp_df <- data.frame(waterYear = i, day_of_year = days)
    df <- rbind(df, temp_df)
  }
  df2 <- cbind(df, {{data}})
  df3 <- df2[, !duplicated(colnames(df2))]

  return(df3)
}
