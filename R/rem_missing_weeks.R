#' Title
#'
#' @param x
#' @param days
#'
#' @return
#' @export
#'
#' @examples
rem_missing_wks <- function(x, days){

  df <- {{x}}

  toremove <- df %>%
    group_by(STATION_NUMBER, waterYear, weeks) %>%
    select(-c(Date, Parameter, day_of_year, month)) %>%
    mutate(week_nas = sum(is.na(Value))) %>%
    filter(week_nas > {{days}}) %>%
    distinct()%>%
    ungroup()

  df_removed <- anti_join(df, toremove, by = c('STATION_NUMBER', 'waterYear', 'weeks'))

  return(df_removed)
}
