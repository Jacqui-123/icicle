#removes months with missing days and then years with missing months

#' Title
#'
#' @param x
#' @param days
#'
#' @return
#' @export
#'
#' @examples
rem_missing_years <- function(x, days){
  df <- {{x}}
  df_mnths_removed <- rem_missing_months(df, {{days}})

  toremove <- df_mnths_removed %>%
    group_by(STATION_NUMBER, waterYear) %>%
    summarize(month = n_distinct(month)) %>%
    filter(month < 12) %>%
    ungroup()

  df_removed <- anti_join(df_mnths_removed, toremove, by = c('STATION_NUMBER', 'waterYear'))

  return(df_removed)

}
