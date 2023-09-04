
{{ config(
    materialized="table",
    schema="dbt_muddin"
) }}

with int_game_sales as ( 
    SELECT *
    FROM {{ ref("int_game_sales") }}
),

dim_pop_pub as (
    SELECT 
    publisher,
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY publisher
)

SELECT *
FROM dim_pop_pub
