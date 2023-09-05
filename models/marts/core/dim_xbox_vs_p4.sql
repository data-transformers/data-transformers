
{{ config(
    materialized="table",
    schema="dbt_muddin"
) }}

with int_game_sales as ( 
    SELECT console, north_america, europe, japan, rest_of_world
    FROM {{ ref("int_game_sales") }}
),

sum_xbox_vs_p4 as (
    SELECT 
    console,
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY console
),

dim_xbox_vs_p4 as (
    SELECT 
    console,
    na_sales+eu_sales+jap_sales+row_sales as global_sales
    FROM sum_xbox_vs_p4
)

SELECT  *
FROM dim_xbox_vs_p4
