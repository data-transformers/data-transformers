
{{ config(
    materialized="table",
    schema="dbt_muddin"
) }}

with int_game_sales as ( 
    SELECT genre, north_america, europe, japan, rest_of_world 
    FROM {{ ref("int_game_sales") }}
),

avg_sales as (
    SELECT genre, AVG(north_america) as avg_na, AVG(europe) as avg_eu, AVG(japan) as avg_ja, AVG(rest_of_world) as avg_row 
    FROM int_game_sales
    GROUP BY genre 
), 

dim_avg_glob_sales as (
    SELECT genre, (avg_na + avg_eu + avg_ja + avg_row)/4 as avg_global
    FROM avg_sales
)

SELECT  *
FROM dim_avg_glob_sales
