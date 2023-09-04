
{{ config(
    materialized="table",
    schema="dbt_muddin"
) }}

with int_game_sales as ( 
    SELECT publisher, year, north_america, europe, japan, rest_of_world 
    FROM {{ ref("int_game_sales") }}
),

dim_old_pub as (
    SELECT 
    publisher,
    year,
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY publisher, year
    ORDER BY year ASC
    LIMIT 3

)

SELECT  *
FROM dim_old_pub
