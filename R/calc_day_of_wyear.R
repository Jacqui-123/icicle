

#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
calc_day_of_wyear <- function(data){
  #not sure if this is better than "ice_day_of_wyear..."

  grouped_df <- {{data}} %>%
    group_by(STATION_NUMBER, waterYear) %>%
    mutate(day_of_year = row_number()) %>%
    ungroup()

  counts <- grouped_df %>%
    group_by(STATION_NUMBER, waterYear) %>%
    summarize(count = n())

  wrong_num_groups <- counts %>% filter(count !=365 & count != 366)
  if(nrow(wrong_num_groups) > 0){
    warning("The following groups do not have 365 or 366 values:\n",
            paste0("STATION_NUMBER: ", wrong_num_groups$STATION_NUMBER,
                   ", waterYear: ", wrong_num_groups$waterYear,
                   ", Values: ", wrong_num_groups$count, collapse = "\n"))
  }
  rm(counts, wrong_num_groups)
  return(grouped_df)

}

