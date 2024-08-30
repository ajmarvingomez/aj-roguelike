class_name Tile
extends Sprite2D
## Our basic Tile
##
## tutorial: https://selinadev.github.io/06-rogueliketutorial-02/

var _definition: TileDefinition

func _init(grid_position: Vector2i, tile_definition: TileDefinition) -> void:
	centered = false # We want to mark the tile from top left
	position = Grid.grid_to_world(grid_position) ## Set grid based on grid position
	set_tile_type(tile_definition)

func set_tile_type(tile_definition: TileDefinition) -> void: ## Set the type of tile at the coordinates
	_definition = tile_definition
	texture = _definition.texture
	modulate = _definition.color_dark

func is_walkable() -> bool:
	return _definition.is_walkable

func is_transparent() -> bool:
	return _definition.is_transparent
