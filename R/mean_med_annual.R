

#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
mean_med_annual <- function(data){
  input_data <- {{data}}
 # results <- input_data %>%
  #dplyr::group_by(STATION_NUMBER, waterYear) %>%
    #dplyr::summarize(annual_mean = round(mean(Value), 3), annual_median = round(median(Value),3), annual_sd = sd(Value)) %>% dplyr::ungroup()
  #yrs_all <- 1970:2020
  #results <-results %>% tidyr::complete(waterYear = yrs_all)
  return(results)
}

#make a separate function that sanity checks 365 days/year
#people use the sanity checks themselves
#do warnings later on
