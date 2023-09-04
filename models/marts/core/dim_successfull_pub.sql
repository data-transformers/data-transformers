
{{ config(
    materialized="table",
    schema="dbt_muddin"
) }}

with int_game_sales as ( 
    SELECT *
    FROM {{ ref("int_game_sales") }}
),

region_sum as (
    SELECT 
    genre,
    publisher,
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY genre, publisher
),

dim_successful_pub as (
    SELECT
    genre,
    publisher,
    na_sales + eu_sales + jap_sales + row_sales as total_sales
    FROM region_sum
)

SELECT *
FROM dim_successful_pub
