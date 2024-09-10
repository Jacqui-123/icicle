
#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
calc_mn_md_week <- function(x){
  df <- {{x}}
  results <- df %>%
    group_by(STATION_NUMBER, weeks) %>%
    summarize(weekly_mean = round(mean(Value),1), weekly_median = round(median(Value), 1))
  return(results)
}
