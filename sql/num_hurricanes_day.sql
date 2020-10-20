# ibtracs column description: https://www.ncdc.noaa.gov/ibtracs/pdf/IBTrACS_v04_column_documentation.pdf

SELECT
  TIMESTAMP_TRUNC(iso_time, day) as year_month_day,
  count(name) as n_cyclones
FROM
  `bigquery-public-data.noaa_hurricanes.hurricanes`
GROUP BY
  year_month_day
ORDER BY 1