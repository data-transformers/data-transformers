{{
    config(
        materialized='table'
    )
}}

ALTER TABLE {{ ref('stg_ps_4_video_game_sales') }}
ADD COLUMN console CHAR

-- INSERT INTO PS_4_GAME_SALES (console)
-- VALUES(playstation)