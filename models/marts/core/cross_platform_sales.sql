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
    name,
    console,
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY name, console
),

total as (
    SELECT
    name,
    na_sales + eu_sales + jap_sales + row_sales as total_sales,
    console
    FROM region_sum
),
cross_platform_games as (
    SELECT name, console
    FROM total
    GROUP BY name, console
    HAVING COUNT(*) > 1
)
-- cross_platform_games as (
--     SELECT
--         Name,
--         SUM(CASE WHEN Console = 'PS4' THEN total_sales ELSE 0 END) AS ps4_Sales,
--         SUM(CASE WHEN Console = 'Xbox' THEN total_sales ELSE 0 END) AS xbox_Sales
--     FROM total
--     WHERE Console IN ('PS4', 'Xbox')
--     GROUP BY Name
--     ORDER BY Name
-- )

SELECT * FROM cross_platform_games