# https://en.wikipedia.org/wiki/Saffir%E2%80%93Simpson_scale

SELECT
  CAST(season AS INT64) AS season_int,
  sid,
  max(USA_SSHS) category
FROM
  `bigquery-public-data.noaa_hurricanes.hurricanes`
WHERE
  basin = "NA"
  AND USA_SSHS IS NOT NULL
  AND USA_SSHS >= 1
  AND CAST(season AS INT64) > 1966
GROUP BY
  season_int, sid