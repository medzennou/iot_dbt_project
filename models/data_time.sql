WITH streaming_data AS (
SELECT
  datehour,
  TIMESTAMP_TRUNC(datehour, HOUR, 'UTC') AS hour,
  TIMESTAMP_TRUNC(datehour, MINUTE, 'UTC') AS minute,
  TIMESTAMP_TRUNC(datehour, SECOND, 'UTC') AS second,
  sensorID,
  gpsspeed,
  Oil_Temperature,
  Pump_Speed
FROM
  etl-pipeline-project.training.streaming_table_iot
ORDER BY datehour DESC
)
# calculate aggregations on stream for reporting:
SELECT
 ROW_NUMBER() OVER() AS dashboard_sort,
 minute,
 COUNT(DISTINCT sensorID) AS total_sensor,
 Max(gpsspeed) AS max_gpsspeed,
FROM streaming_data
GROUP BY minute, datehour