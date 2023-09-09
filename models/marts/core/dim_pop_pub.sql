
{{ config(
    materialized="table"
) }}

with int_game_sales as ( 
    SELECT *
    FROM {{ ref("int_game_sales") }}
),

regional_sales as (
    SELECT 
    publisher,
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY publisher
),

dim_pop_pub as (
    SELECT
    publisher,
    na_sales + eu_sales + jap_sales + row_sales as total_sales
    FROM regional_sales
    ORDER BY total_sales DESC
    LIMIT 3
)

SELECT *
FROM dim_pop_pub
