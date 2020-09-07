# README

basic outline of project.
- create a Game model with a has many relationship with Square model. Each Game model when instantiated can have up to 9 Square models belonging to it.
- each square instance has the following attributes: position/square no., value to hold either 'x' or 'o', user_id/player_id
- a User can have many squares through moves. A Move model will hold the relationship between User and Square
