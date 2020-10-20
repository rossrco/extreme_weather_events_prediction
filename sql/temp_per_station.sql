# ghcn_d description: https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt
# ghcn_d station info: ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/all/<station_name>.dly

SELECT id
  , date
  , AVG(IF(element LIKE '%PRCP', value, null)) percipitation
  , AVG(IF(element LIKE '%TMIN', value, null)) temp_min
  , AVG(IF(element LIKE '%TMAX', value, null)) temp_max
FROM `bigquery-public-data.ghcn_d.ghcnd_1921`
WHERE element IN ("PRCP", "TMIN", "TMAX")
GROUP BY 1, 2