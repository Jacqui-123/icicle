
#' Calculate freeze and thaw dates
#'
#' @param data data frame used to calculate freeze and thaw dates
#'
#' @return A data frame
#' @export
#'
#' @examples
ice_group_2 <- function(data) {

  start_date_lst <- list()
  end_date_lst <- list()
  start_flow_lst <- list()
  end_flow_lst <- list()
  start_doy_lst <- list()
  end_doy_lst <- list()

  for (i in unique({{data}}$waterYear)){

    df_subset <- {{data}}[{{data}}$waterYear == i,]

    #calc rle for B symbol
    rle_m = rle(df_subset$Symbol == "B")

    #find index for max run of B symbols
    max_run_index <- which.max(rle_m$lengths)

    #find end start and index of max run of B symbols
    end <- cumsum(rle_m$lengths)[max_run_index]
    start <- end - rle_m$lengths[max_run_index] +1

    #find date at end, start index of the max run
    date_end = df_subset$Date[end]
    date_start = df_subset$Date[start]

    #find flow at end, start index
    flow_end = df_subset$Value[end]
    flow_start = df_subset$Value[start]

    #find doy at end, start index
    doy_end = df_subset$day_of_year[end]
    doy_start = df_subset$day_of_year[start]

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

  Freeze_Date <- as.Date(unlist(start_date_lst))
  Thaw_Date <- as.Date(unlist(end_date_lst))
  Flow_Freeze <- unlist(start_flow_lst)
  Flow_Thaw <- unlist(end_flow_lst)
  Freeze_DOY <-unlist(start_doy_lst)
  Thaw_DOY <- unlist(end_doy_lst)

  df <- cbind.data.frame(Freeze_Date,Freeze_DOY,Flow_Freeze,Thaw_Date,Thaw_DOY, Flow_Thaw)

  Ice_coverage_dates_flow <- tibble::rownames_to_column(df, "waterYear")
  Ice_coverage_dates_flow <- rownames_to_column(df, "waterYear")
  return(Ice_coverage_dates_flow)

}

