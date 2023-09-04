select
    _row as id,  
    game AS name, 
    publisher, 
    genre, 
    year, 
    north_america, 
    europe, japan, 
    rest_of_world,
<<<<<<< HEAD
    global,
    'ps4' as console
=======
    global
>>>>>>> b26712e581548c9c359889d5dbcf2297b554d375
from {{ source("video_game_sales", "PS_4_GAME_SALES")}}


