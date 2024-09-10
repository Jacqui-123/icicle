
#' Title
#'
#' @param x
#' @param days
#'
#' @return
#' @export
#'
#' @examples
rem_missing_months <- function(x, days){

  df <- {{x}} %>% mutate(month = month(Date))

  toremove <- df %>%
    group_by(STATION_NUMBER, waterYear, month) %>%
    select(-c(Date, Parameter, day_of_year, weeks)) %>%
    mutate(month_nas = sum(is.na(Value))) %>%
    filter(month_nas > {{days}}) %>%
    distinct() %>%
    ungroup()

  df_removed <- anti_join(df, toremove, by = c('STATION_NUMBER', 'waterYear', 'month'))

  return(df_removed)
}
