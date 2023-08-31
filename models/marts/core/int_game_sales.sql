with ps_4_game_sales as ( 
    SELECT * 
    FROM {{ ref("stg_ps_4_video_game_sales") }}
),

xbox_game_sales as (
    SELECT *
    FROM {{ ref("stg_xbox_game_sales") }}
),

int_video_game_sales as (
    SELECT 
     id,  
     name, 
    publisher, 
    genre, 
    year, 
    north_america, 
    europe, japan, 
    rest_of_world,
    global,
    'ps4' as console 
    FROM ps_4_game_sales
    UNION
    SELECT 
     id,  
    name, 
    publisher, 
    genre, 
    year, 
    north_america, 
    europe, japan, 
    rest_of_world,
    global,
    'xbox' as console 
    FROM xbox_game_sales
)

select * from int_video_game_sales