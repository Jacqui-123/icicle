
#' Calculate onset of freshet
#'
#' @param data A data frame used to calculate onset of freshet
#'
#' @return A data frame with the onset of freshet dates, flow values and day of the year.
#' @export
#'
#' @examples
ice_group_3 <- function(data) {
  index <- 0
  f_index <- 16
  date_lst <- list()
  flow_lst <- list()
  stn_nu <- list()
  doy_lst <- list()

  for (i in unique({{data}}$waterYear)) { #first loop
    #subset data by year, resetting at each year
    index = 0
    f_index = 16
    df_subset <- {{data}}[{{data}}$waterYear == i,]
    df_subset <- df_subset %>%
      #data tidying:delete dates before Feb 12, so rolling mean calc starts on March 1

      dplyr::mutate(Date = as.Date(Date)) %>%
      #filter(month(Date) %in% c(3,4,5,6))
      dplyr::mutate(new_col = format(Date,"%m-%d")) %>%
      dplyr::filter(lubridate::month(Date) >= 2 & lubridate::month(Date) < 7) %>%
      dplyr::filter(!(new_col %in% c("02-01", "02-02", "02-03", "02-04", "02-05", "02-06", "02-07", "02-08", "02-09", "02-10", "02-11")))

    #calc rolling 16 day mean
    rollmn <- zoo::rollmean(df_subset$Value, k = 16, width = 16)
      dplyr::mutate(Date = as.Date(Date)) %>%
      #filter(month(Date) %in% c(3,4,5,6))
      dplyr::mutate(new_col = format(Date,"%m-%d")) %>%
      dplyr::filter(lubridate::month(Date) >= 2 & lubridate::month(Date) < 7) %>%
      dplyr::filter(!(new_col %in% c("02-01", "02-02", "02-03", "02-04", "02-05", "02-06", "02-07", "02-08", "02-09", "02-10", "02-11")))

    #calc rolling 16 day mean
    rollmn <- zoo::rollmean(df_subset$Value, k = 16, width = 16)

    for (j in rollmn) { #second loop
      #increment index
      index = index + 1
      f_index = f_index + 1

      #find rolling mean value at the index and multiply by 1.5
      rollmnvalue <- rollmn[index] #roll mean = 0.81
      rollmnvalue1.5 <- rollmnvalue*1.5 #1.215

      #get the flow value at that index
      flowvalue <- df_subset$Value[f_index] #flow = 0.654

      if (flowvalue > rollmnvalue1.5 & f_index < 123 ) { #third loop
        #append date, flow value to a list using the index numbers
        dt <- df_subset$Date[f_index]
        fl <- df_subset$Value[f_index]
        st <- df_subset$STATION_NUMBER[f_index]
        doy <- df_subset$day_of_year[f_index]
        # print(dt)
        #  print(fl)
        #  print("end")
        date_lst[[i]] <- dt
        flow_lst[[i]] <- fl
        stn_nu[[i]] <- st
        doy_lst[[i]] <- doy
        Freshet_Date <- as.Date(unlist(date_lst))
        Freshet_Flow <- unlist(flow_lst)
        Station_Number <- unlist(stn_nu)
        Freshet_Dayofyear <- unlist(doy_lst)
        df <- cbind.data.frame(Station_Number, Freshet_Date, Freshet_Dayofyear, Freshet_Flow)
        break
      }

    }

  }

  Freshet_dates_flow <- tibble::rownames_to_column(df, "waterYear")

  Freshet_dates_flow <- tibble::rownames_to_column(df, "waterYear")

  return(Freshet_dates_flow)
}


