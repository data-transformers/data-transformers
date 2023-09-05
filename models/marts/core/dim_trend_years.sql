
{{ config(
    materialized="table",
    schema="dbt_muddin"
) }}

with int_game_sales as ( 
    SELECT console, year, north_america, europe, japan, rest_of_world
    FROM {{ ref("int_game_sales") }}
),

sum_trend_years as (
    SELECT 
    console, 
    year, 
    SUM(north_america) as na_sales, 
    SUM(europe) as eu_sales, 
    SUM(japan) as jap_sales, 
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY console, year
),

dim_trend_years as (
    SELECT console, 
    year,
    na_sales+eu_sales+jap_sales+row_sales as global_sales
    FROM sum_trend_years
    ORDER BY year, console
)

SELECT  *
FROM dim_trend_years
