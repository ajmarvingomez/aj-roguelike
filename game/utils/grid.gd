class_name Grid
extends Object
## Defines the grid in our game
##

const tile_size = Vector2i(16, 16) ## Defines the size of the tiles

static func grid_to_world(grid_pos: Vector2i) -> Vector2i:
    var world_pos: Vector2i = grid_pos * tile_size
    return world_pos

static func world_to_grid(world_pos: Vector2i) -> Vector2i:
    var grid_pos: Vector2i = world_pos / tile_size
    return grid_pos