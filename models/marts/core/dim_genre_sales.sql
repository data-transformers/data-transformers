
{{ config(
    materialized="table",
    schema="dbt_bullah"
) }}

with int_game_sales as ( 
    SELECT genre, global 
    FROM {{ ref("int_game_sales") }}
),

dim_genre_sales as (
    SELECT 
    genre,
    SUM(global) as sales
    FROM int_game_sales
    GROUP BY genre
    ORDER BY sales DESC
    LIMIT 1
)

SELECT * FROM dim_genre_sales