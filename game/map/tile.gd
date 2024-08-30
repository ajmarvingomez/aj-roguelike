class_name Tile
extends Sprite2D
## Our basic Tile
##
## tutorial: https://selinadev.github.io/06-rogueliketutorial-02/

var _definition: TileDefinition
var is_explored: bool = false: ## Start not explored
	set(value):
		is_explored = value ## set explored to value
		if is_explored and not visible: ## Set tile visibility the first time it is explored
			visible = true

var is_in_view: bool = false: ## Start out of view
	set(value):
		is_in_view = value
		modulate = _definition.color_lit if is_in_view else _definition.color_dark ## If it's in view, set color to lit, otherwise set color to dark.
		if is_in_view and not is_explored:
			is_explored = true


func _init(grid_position: Vector2i, tile_definition: TileDefinition) -> void:
	centered = false # We want to mark the tile from top left
	visible = false # Start Tiles hidden
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
