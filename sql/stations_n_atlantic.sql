# find all weather stations in a custom polygon in the North Atlantic Ocean

select
id,
state,
name,
latitude,
longitude
from `bigquery-public-data.ghcn_d.ghcnd_stations`
WHERE
ST_CONTAINS(
  ST_MAKEPOLYGON(
    ST_MAKELINE(
      ARRAY(
              select ST_GEOGPOINT(-12.950869, 53.431059) union all
              select ST_GEOGPOINT(-10.342842, 35.002107) union all
              select ST_GEOGPOINT(-19.931662, 13.986127) union all
              select ST_GEOGPOINT(-9.352620, 0.0)        union all
              select ST_GEOGPOINT(-49.101915, 0.384726)  union all
              select ST_GEOGPOINT(-71.903541, 13.516013)
            )
          )
        )
  ,ST_GEOGPOINT(longitude, latitude)) IS TRUE
ORDER BY id