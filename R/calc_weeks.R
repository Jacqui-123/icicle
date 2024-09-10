
#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
calc_weeks <- function(data){

  df <- {{data}} %>%
    group_by(STATION_NUMBER, waterYear) %>%
    dplyr::mutate(weeks = rep(1:(ceiling(n()/7)), each = 7)[1:n()]) %>%
    mutate(weeks = if_else(weeks == 53, 52, weeks)) %>% #make the one day week 53 be week 52. Issue is that then there are 9 days in week 52 in leap years. Could just omit feb 29th completely?
    ungroup()
}

#df_ready <- calc_weeks(df_doy)
#this needs to be inside the main function
#check_max <- df %>%
 # mutate(max = max(weeks)) %>%
  #filter(max > 52)

#if(nrow(check_max) > 0){
 # warning("There are more than 52 weeks in the year, check the week function or data")
#} else {"all years have 52 weeks in a year"}
