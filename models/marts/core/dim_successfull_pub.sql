{{ config(
    materialized="table"
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

genre_sales_rank as (
    SELECT
    genre,
    publisher,
    na_sales + eu_sales + jap_sales + row_sales as total_sales,
    RANK() OVER (PARTITION BY GENRE ORDER BY NA_SALES + EU_SALES + JAP_SALES + ROW_SALES DESC) AS sales_rank
    FROM region_sum
),

dim_successful_pub as (
SELECT
    genre,
    publisher,
    total_sales
FROM genre_sales_rank
WHERE sales_rank = 1
)

SELECT genre, publisher, total_sales
FROM dim_successful_pub
