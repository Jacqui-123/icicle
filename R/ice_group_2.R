
#' Calculate freeze and thaw dates
#'
#' @param data input data used to calculate the freeze and thaw dates
#' @param year_column column of year values in the dataframe
#' @param value_column column of flow values in the dataframe
#' @param symbol_column column of symbol values in the dataframe
#' @param date_column column of daily date values in the dataframe
#' @param day_of_yr_column column of day of the year in the dataframe
#'
#' @return A data frame with freeze and thaw dates for each year
#' @export
#'
#' @examples
ice_group_2 <- function(data, year_column = "waterYear", value_column = "Value", symbol_column = "Symbol", date_column = "Date", day_of_yr_column = "day_of_year") {

  start_date_lst <- list()
  end_date_lst <- list()
  start_flow_lst <- list()
  end_flow_lst <- list()
  start_doy_lst <- list()
  end_doy_lst <- list()

  for (i in unique({{data}}[[year_column]])){

    df_subset <- {{data}}[{{data}}[[year_column]] == i,]

    #calc rle for B symbol
    rle_m = rle(df_subset[[symbol_column]] == "B")

    #find index for max run of B symbols
    max_run_index <- which.max(rle_m$lengths)

    #find end start and index of max run of B symbols
    end <- cumsum(rle_m$lengths)[max_run_index]
    start <- end - rle_m$lengths[max_run_index] +1

    #find date at end, start index of the max run
    date_end = df_subset[[date_column]][end]
    date_start = df_subset[[date_column]][start]

    #find flow at end, start index
    flow_end = df_subset[[value_column]][end]
    flow_start = df_subset[[value_column]][start]

    #find doy at end, start index
    doy_end = df_subset[[day_of_yr_column]][end]
    doy_start = df_subset[[day_of_yr_column]][start]

    #append dates to the list
    start_date_lst[[i]] <- date_start
    end_date_lst[[i]] <- date_end

    #append flows to the list
    start_flow_lst[[i]] <- flow_start
    end_flow_lst[[i]] <- flow_end

    #append doy to the list
    start_doy_lst[[i]] <- doy_start
    end_doy_lst[[i]] <- doy_end

  }

  Freeze_Date <- lubridate::as_date(unlist(start_date_lst))
  Thaw_Date <- lubridate::as_date(unlist(end_date_lst))
  Flow_Freeze <- unlist(start_flow_lst)
  Flow_Thaw <- unlist(end_flow_lst)
  Freeze_DOY <-unlist(start_doy_lst)
  Thaw_DOY <- unlist(end_doy_lst)

  df <- cbind.data.frame(Freeze_Date,Freeze_DOY,Flow_Freeze,Thaw_Date,Thaw_DOY, Flow_Thaw)

  Ice_coverage_dates_flow <- tibble::rownames_to_column(df, "Year")
  return(Ice_coverage_dates_flow)

}

