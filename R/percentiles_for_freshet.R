
#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
freshet_percentile <- function(data){

  df <- data %>%
    group_by(STATION_NUMBER, waterYear) %>%
    mutate(sum_runoff = sum(Value)) %>%
    mutate(runoff_10 = sum_runoff*.1) %>%
    mutate(cum_sum = cumsum(Value))

  result <- df %>%group_by(STATION_NUMBER, waterYear) %>%


    do({
      df_subset <- .
      perc_cumsum <- df_subset[which.min(abs(df_subset$runoff_10-df_subset$cum_sum)),]
      perc_cumsum <- data.frame(perc_cumsum)
    })
  return(result)
}
