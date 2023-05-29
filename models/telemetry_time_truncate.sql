{{ config(materialized="view") }}
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
SELECT *
FROM streaming_data
