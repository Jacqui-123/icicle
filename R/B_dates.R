#' Title
#'
#' @param df
#'
#' @return
#' @export
#'
#' @examples
b_dates <- function(df){

  #Annual: first b date, last b date, first b value, last b value
  #number of days open water and ice effected

  input_df <- {{df}}
  output_df_firstB <- input_df %>%
    group_by(STATION_NUMBER, waterYear) %>%
    arrange(STATION_NUMBER, waterYear, Date) %>%
    filter(Symbol == "B") %>%
    slice(1) %>%
    ungroup() %>%
    select(STATION_NUMBER, waterYear, first_B_Date = Date, first_B_Value = Value, first_B_doy = day_of_year)


  output_df_lastB <- input_df %>%
    group_by(STATION_NUMBER, waterYear) %>%
    arrange(STATION_NUMBER, waterYear, Date) %>%
    filter(Symbol == "B") %>%
    slice_tail(n = 1) %>%
    ungroup() %>%
    select(STATION_NUMBER, waterYear, last_B_Date = Date, last_B_Value = Value, last_B_doy = day_of_year)

  output_df <- merge(output_df_firstB, output_df_lastB, on = c(STATION_NUMBER, waterYear))

  output_df <- output_df %>%
    group_by(STATION_NUMBER, waterYear) %>%
    mutate(duration_ice = last_B_doy - first_B_doy) %>%
    mutate(duration_ow = 365 - duration_ice)
  return(output_df)

}
