#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
calc_mn_md_seasonal <- function(data){
  input_data <- {{data}}
  results <- input_data %>%
    dplyr::filter(month(Date) %in% c(3,4,5,6,7,8,9,10)) %>%
    dplyr::group_by(STATION_NUMBER, waterYear) %>%
    dplyr::summarize(seasonal_mean = round(mean(Value), 3), seasonal_median = round(median(Value),3), seasonal_sd = round(sd(Value)),3) %>% ungroup()
  yrs_all <- 1970:2020

  results <-results %>% complete(waterYear = yrs_all)
  return(results)
}
