class_name MapData
extends RefCounted
## Keeps track of the map data


## Tile types are defined here.
const tile_types = {
	"floor": preload("res://assets/definitions/tiles/tile_definition_floor.tres"),
	"wall": preload("res://assets/definitions/tiles/tile_definition_wall.tres")
}

var width: int
var height: int
var tiles: Array[Tile]
var entities: Array[Entity]

func _init(map_width: int, map_height: int) -> void:
	width = map_width
	height = map_height
	entities = []
	_setup_tiles()

func _setup_tiles() -> void:
	tiles = []
	for y in height:
		for x in width:
			var tile_position := Vector2i(x, y)
			var tile := Tile.new(tile_position, tile_types.wall)
			tiles.append(tile)
	for x in range(30, 34):
		var tile: Tile = get_tile(Vector2i(x, 22))
		tile.set_tile_type(tile_types.wall)

func get_tile(grid_position: Vector2i) -> Tile: ## Get tile from a set of coordinates
	var tile_index: int = grid_to_index(grid_position)
	if tile_index == -1:
		return null
	return tiles[tile_index]

func get_tile_xy(x: int, y: int) -> Tile: ## Get Tile Coordinates
	var grid_position := Vector2i(x, y)
	return get_tile(grid_position)

func get_blocking_entity_at_location(grid_position: Vector2i) -> Entity:
	for entity in entities:
		if entity.is_blocking_movement() && entity.grid_position == grid_position:
			return entity
	return null

func grid_to_index(grid_position: Vector2i) -> int:
	if not is_in_bounds(grid_position):
		return -1
	return grid_position.y * width + grid_position.x

func is_in_bounds(coordinate: Vector2i) -> bool: ## Check if tile is in bounds
	return (
		0 <= coordinate.x
		and coordinate.x < width
		and 0 <= coordinate.y
		and coordinate.y < height
	)
