select
    _row as id,  
    game AS name, 
    publisher, 
    genre, 
    year, 
    north_america, 
    europe, japan, 
    rest_of_world,
    global
from {{ source("video_game_sales", "PS_4_GAME_SALES")}}


