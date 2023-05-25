-- dbt model: gps_speed_1min
-- Source: Specify the source table or view containing the raw data
{{ config(materialized="view") }}
with
    source_data as (
        select
            timestamp_trunc(datehour, second) as second_timestamp,
            avg(gpsspeed) as average_speed
        from  `etl-pipeline-project.training.streaming_table_iot`
        group by 1
    )

-- Model: Define the final output table structure
select second_timestamp, average_speed
from source_data
