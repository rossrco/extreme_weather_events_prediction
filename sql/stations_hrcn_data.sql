WITH
  hrcn AS (
  SELECT
    sid,
    DATE(iso_time) AS iso_date,
    latitude,
    longitude,
    WMO_WIND
  FROM
    `bigquery-public-data.noaa_hurricanes.hurricanes`
  WHERE extract(year from iso_time) = 1973)

SELECT
  sid,
  iso_date,
  date,
  latitude,
  longitude,
  WMO_WIND,
  value AS avg_temp
FROM
  hrcn
LEFT JOIN
  `bigquery-public-data.ghcn_d.ghcnd_1973` ghcnd_1973
ON
  hrcn.iso_date = date(ghcnd_1973.date)
  AND ghcnd_1973.id = 'GPM00078894'
  AND ghcnd_1973.element ='TAVG'
  AND date IS NOT NULL
  AND WMO_WIND IS NOT NULL
ORDER BY iso_date
LIMIT 100000