-- dbt model: gps_speed_1min
-- Source: Specify the source table or view containing the raw data
{{ config(materialized="table") }}
with
    source_data as (
        select
            sensorID as sensorID,
            avg(gpsspeed) as average_speed,
            avg(Oil_Temperature) as average_Oil_Temperature,
            avg(Pump_Speed) as average_Pump_Speed
        from  `etl-pipeline-project.training.streaming_table_iot`
        group by 1
    )

-- Model: Define the final output table structure
select sensorID, average_speed,average_Oil_Temperature,average_Pump_Speed
from source_data
