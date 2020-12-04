WITH
  hrcn_agg AS (
  SELECT
    sid,
    DATE(iso_time) AS date,
    AVG(latitude)  AS avg_lat,
    AVG(longitude) AS avg_lng,
    AVG(WMO_WIND)  AS avg_wind_speed
  FROM
    `bigquery-public-data.noaa_hurricanes.hurricanes`
  WHERE EXTRACT(year FROM iso_time) = 2000
  GROUP BY date, sid),
  
  guadalupe_agg AS (
  SELECT
    DATE(date) AS date,
    AVG(value) AS avg_temp
  FROM `bigquery-public-data.ghcn_d.ghcnd_2000` ghcnd_2000
  WHERE
    ghcnd_2000.id = 'GPM00078894'
    AND ghcnd_2000.element ='TAVG'
  GROUP BY date)

SELECT
  hrcn_agg.date,
  sid,
  avg_lat,
  avg_lng,
  avg_wind_speed,
  avg_temp
FROM
  hrcn_agg
LEFT JOIN
  guadalupe_agg ON hrcn_agg.date = guadalupe_agg.date
ORDER BY 1
LIMIT 1000