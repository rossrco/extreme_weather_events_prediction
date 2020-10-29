# https://en.wikipedia.org/wiki/Saffir%E2%80%93Simpson_scale

WITH hurricanes AS
(
SELECT
  CAST(season AS INT64) AS season_int,
  sid,
  max(WMO_WIND) max_windspeed
FROM
  `bigquery-public-data.noaa_hurricanes.hurricanes`
WHERE
  basin = "NA"
  AND WMO_WIND IS NOT NULL
  AND CAST(season AS INT64) > 1966
GROUP BY
  season_int, sid
)

SELECT
  season_int,
  sid,
  CASE
    WHEN max_windspeed <= 33 THEN 'depression'
    WHEN max_windspeed <= 63 THEN 'storm'
    WHEN max_windspeed <= 82 THEN 'cat_1'
    WHEN max_windspeed <= 95 THEN 'cat_2'
    WHEN max_windspeed <= 112 THEN 'cat_3'
    WHEN max_windspeed <= 136 THEN 'cat_4'
    ELSE 'cat_5'
  END AS category,
FROM hurricanes