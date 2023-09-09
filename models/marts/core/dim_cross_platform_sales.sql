{{ config(
    materialized="table"
) }}

with int_game_sales as ( 
    SELECT *
    FROM {{ ref("int_game_sales") }}
),


region_sum as (
    SELECT
    name,
    console,
    north_america as na_sales,
    europe as eu_sales,
    japan as jpn_sales,
    rest_of_world as row_sales
    FROM int_game_sales
),

ps4_game_sales as (
    SELECT
    name,
    na_sales + eu_sales + jpn_sales + row_sales as ps4_sales
    FROM region_sum
    WHERE console = 'ps4'
),

xbox_game_sales as (
    SELECT
    name,
    na_sales + eu_sales + jpn_sales + row_sales as xbox_sales
    FROM region_sum
    WHERE console = 'xbox'
),

cross_platform_games as (
    SELECT ps4_game_sales.name, ps4_game_sales.ps4_sales, xbox_game_sales.xbox_sales
    FROM ps4_game_sales
    INNER JOIN
    xbox_game_sales ON ps4_game_sales.name=xbox_game_sales.name
)

-- region_sum as (
--     SELECT 
--     name,
--     console,
--     SUM(north_america) as na_sales,
--     SUM(europe) as eu_sales,
--     SUM(japan) as jap_sales,
--     SUM(rest_of_world) as row_sales
--     FROM int_game_sales
--     GROUP BY name, console
-- ),

-- total as (
--     SELECT
--     name,
--     na_sales + eu_sales + jap_sales + row_sales as total_sales,
--     console
--     FROM region_sum
-- )

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