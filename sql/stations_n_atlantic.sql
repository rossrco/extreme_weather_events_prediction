# find all weather stations in a custom polygon in the North Atlantic Ocean

SELECT
stat.id,
LEFT(stat.id, 2) AS country,
stat.state,
stat.name,
stat.latitude,
stat.longitude,
inv.element,
inv.firstyear,
inv.lastyear 
FROM `bigquery-public-data.ghcn_d.ghcnd_stations` stat
LEFT JOIN `bigquery-public-data.ghcn_d.ghcnd_inventory` inv ON stat.id = inv.id
  AND inv.element IN ("TMAX", "TMIN", "ACMC", "AWDR", "AWND", "EVAP", "MXPN")
WHERE
ST_CONTAINS(
  ST_MAKEPOLYGON(
    ST_MAKELINE(
      ARRAY(
              select ST_GEOGPOINT(-1.306379, 49.316014)  union all
              select ST_GEOGPOINT(-10.342842, 35.002107) union all
              select ST_GEOGPOINT(-19.931662, 13.986127) union all
              select ST_GEOGPOINT(-9.352620, 0.0)        union all
              select ST_GEOGPOINT(-49.101915, 0.0)       union all
              select ST_GEOGPOINT(-71.903541, 13.516013) union all
              select ST_GEOGPOINT(-77.111534, 7.367272)  union all
              select ST_GEOGPOINT(-76.957330, 34.883146) union all
              select ST_GEOGPOINT(-70.455789, 43.963237) union all
              select ST_GEOGPOINT(-21.150974, 49.144944) union all
              select ST_GEOGPOINT(-1.306379, 49.316014)
            )
          )
        )
  ,ST_GEOGPOINT(stat.longitude, stat.latitude)) IS TRUE
ORDER BY stat.id