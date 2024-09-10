
test_that("testing mean_med_annual function", {

  df <- data.frame(STATION_NUMBER = "00701ADD", waterYear = 1989, Value = .56)
  df_out <- tibble::tibble(STATION_NUMBER = "00701ADD", waterYear = 1989, annual_mean = .56, annual_median = .56, annual_sd = NA_real_)
  expect_equal(mean_med_annual(df), df_out)

  })

#other tests
#more than one value, more than one year
#rep(0.56, 365)
#rep(c(0.56, 0.5, 0.1), 30) put where Value =
#
