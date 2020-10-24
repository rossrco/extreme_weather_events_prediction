# Find all cases where a hurricane is within the boundaries of Florida

SELECT
    sid,
    season,
    name,
    iso_time,
    nature,
    latitude,
    longitude,
    landfall
FROM `bigquery-public-data.noaa_hurricanes.hurricanes` 
WHERE ST_CONTAINS((SELECT
                    state_geom
                   FROM `bigquery-public-data.geo_us_boundaries.states`
                   WHERE state = "FL"),
                  ST_GEOGPOINT(longitude, latitude)) IS TRUE
LIMIT 100