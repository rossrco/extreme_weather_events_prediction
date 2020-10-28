WITH stations AS (
  SELECT
    id,
    LEFT(id, 2) as country,
    state,
    name,
    latitude,
    longitude
  FROM `bigquery-public-data.ghcn_d.ghcnd_stations`
)

SELECT
stations.*,
countries.name
FROM stations
LEFT JOIN `bigquery-public-data.ghcn_d.ghcnd_countries` countries ON stations.country = countries.code
WHERE
ST_CONTAINS(
  ST_MAKEPOLYGON(
    ST_MAKELINE(
      ARRAY(
              SELECT ST_GEOGPOINT(-12.950869, 53.431059) UNION ALL
              SELECT ST_GEOGPOINT(-10.342842, 35.002107) UNION ALL
              SELECT ST_GEOGPOINT(-19.931662, 13.986127) UNION ALL
              SELECT ST_GEOGPOINT(-9.352620, 0.0)        UNION ALL
              SELECT ST_GEOGPOINT(-49.101915, 0.384726)  UNION ALL
              SELECT ST_GEOGPOINT(-71.903541, 13.516013) UNION ALL
              SELECT ST_GEOGPOINT(-76.957330, 34.883146)
            )
          )
        )
  ,ST_GEOGPOINT(longitude, latitude)) IS TRUE
ORDER BY id