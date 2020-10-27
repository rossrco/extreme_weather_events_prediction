# https://en.wikipedia.org/wiki/Saffir%E2%80%93Simpson_scale

SELECT
  CAST(season AS INT64) AS season_int,
  CASE
    WHEN WMO_WIND <= 33 THEN 'depression'
    WHEN WMO_WIND <= 63 THEN 'storm'
    WHEN WMO_WIND <= 82 THEN 'cat_1'
    WHEN WMO_WIND <= 95 THEN 'cat_2'
    WHEN WMO_WIND <= 112 THEN 'cat_3'
    WHEN WMO_WIND <= 136 THEN 'cat_4'
    ELSE 'cat_5'
  END AS category,
  COUNT(DISTINCT sid) AS n_cyclones
FROM
  `bigquery-public-data.noaa_hurricanes.hurricanes`
WHERE
  basin = "NA"
  AND landfall = 0
GROUP BY
  season_int, category