# ibtracs column description: https://www.ncdc.noaa.gov/ibtracs/pdf/IBTrACS_v04_column_documentation.pdf
# ibtracs website: https://www.ncdc.noaa.gov/ibtracs/index.php?name=introduction

SELECT
  CAST(season AS INT64) AS season_int,
  COUNT(DISTINCT sid) AS n_cyclones
FROM
  `bigquery-public-data.noaa_hurricanes.hurricanes`
WHERE dist2land < 20
GROUP BY
  season_int
HAVING
  season_int > 1900
ORDER BY 1