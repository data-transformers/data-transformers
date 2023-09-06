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
    SUM(north_america) as na_sales,
    SUM(europe) as eu_sales,
    SUM(japan) as jap_sales,
    SUM(rest_of_world) as row_sales
    FROM int_game_sales
    GROUP BY name
),

union_tables as (
     SELECT
        'North America' AS Region,
        name,
        na_sales AS Sales,
        ROW_NUMBER() OVER (PARTITION BY 'North America' ORDER BY NA_SALES DESC) AS rn
    FROM region_sum

    UNION ALL

    SELECT
        'Europe' AS Region,
        name,
        eu_sales AS Sales,
        ROW_NUMBER() OVER (PARTITION BY 'Europe' ORDER BY EU_SALES DESC) AS rn
    FROM region_sum

    UNION ALL

    SELECT
        'Japan' AS Region,
        name,
        jap_sales AS Sales,
        ROW_NUMBER() OVER (PARTITION BY 'Japan' ORDER BY JAP_SALES DESC) AS rn
    FROM region_sum

    UNION ALL

    SELECT
        'ROW' AS Region,
        name,
        row_sales AS Sales,
        ROW_NUMBER() OVER (PARTITION BY 'Rest of the World' ORDER BY ROW_SALES DESC) AS rn
    FROM region_sum
)

SELECT
    region,
    name
FROM union_tables
WHERE rn <= 3
