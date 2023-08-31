
with ps_4_game_sales as
(SELECT * 
FROM {{ref("stg_ps_4_video_game_sales")}}),

xbox_game_sales as (
SELECT *
FROM {{ref("stg_xbox_game_sales")}}),

dim_video_game_sales as (
    SELECT * 
    FROM ps_4_game_sales
    UNION
    SELECT * 
    FROM xbox_game_sales
)

select * from dim_video_game_sales