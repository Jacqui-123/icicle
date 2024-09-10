


#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
calc_mn_md_month <- function(data){
  input_data <- {{data}}
  results <- input_data %>%
    mutate(month = factor(lubridate::month(Date, label = TRUE, abbr = TRUE), levels = month.abb)) %>%
    dplyr::group_by(STATION_NUMBER, waterYear, month) %>%
    dplyr::summarize(monthly_mean = round(mean(Value),3), monthly_median = round(median(Value), 3), monthly_std = round(sd(Value), 3)) %>%
    pivot_wider(names_from = month, values_from = c(monthly_mean, monthly_median, monthly_std), names_prefix = "") %>%   select(STATION_NUMBER, waterYear, monthly_mean_Jan, monthly_mean_Feb, monthly_mean_Mar, monthly_mean_Apr, monthly_mean_May, monthly_mean_Jun, monthly_mean_Jul, monthly_mean_Aug, monthly_mean_Sep, monthly_mean_Oct, monthly_mean_Nov, monthly_mean_Dec, monthly_median_Jan, monthly_median_Feb, monthly_median_Mar, monthly_median_Apr, monthly_median_May, monthly_median_Jun, monthly_median_Jul, monthly_median_Aug, monthly_median_Sep, monthly_median_Oct, monthly_median_Nov, monthly_median_Dec, monthly_std_Jan, monthly_std_Feb, monthly_std_Mar, monthly_std_Apr, monthly_std_May, monthly_std_Jun, monthly_std_Jul, monthly_std_Aug, monthly_std_Sep, monthly_std_Oct, monthly_std_Nov, monthly_std_Dec)  %>%
    ungroup()
  yrs_all <- 1970:2020

  results <-results %>% complete(waterYear = yrs_all)
  return(results)
}
