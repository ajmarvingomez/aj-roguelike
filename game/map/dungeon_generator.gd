class_name DungeonGenerator
extends Node
## Dungeon generation
##
##
## @tutorial: https://selinadev.github.io/07-rogueliketutorial-03/

@export_category("Map Dimensions")
@export var map_width: int = 80
@export var map_height: int = 45

@export_category("Rooms RNG")
@export var max_rooms: int = 30
@export var room_max_size: int = 10
@export var room_min_size: int = 6

@export_category("Monsters RNG")
@export var max_monsters_per_room: int = 2

const entity_types = {
	"orc": preload("res://assets/definitions/actors/entity_definition_orc.tres"),
	"troll": preload("res://assets/definitions/actors/entity_definition_troll.tres")
}

var _rng := RandomNumberGenerator.new()

func _carve_tile(dungeon: MapData, x: int, y: int) -> void: ## draw and generate the floor tile at coordinates
	var tile_position = Vector2i(x, y)
	var tile: Tile = dungeon.get_tile(tile_position)
	tile.set_tile_type(dungeon.tile_types.floor)

func _carve_room(dungeon, room: Rect2i) -> void: ## draw and generate the room from a rectangle
	var inner: Rect2i = room.grow(-1) ## shrink the room by one tile on each side
	for y in range(inner.position.y, inner.end.y + 1):
		for x in range(inner.position.x, inner.end.x + 1):
			_carve_tile(dungeon, x, y)

func _tunnel_horizontal(dungeon: MapData, y: int, x_start: int, x_end: int): ## Connects rooms horizontally
	var x_min: int = mini(x_start, x_end)
	var x_max: int = maxi(x_start, x_end)
	for x in range(x_min, x_max + 1):
		_carve_tile(dungeon, x, y)

func _tunnel_vertical(dungeon: MapData, x: int, y_start: int, y_end: int): ## Connects rooms vertically
	var y_min: int = mini(y_start, y_end)
	var y_max: int = maxi(y_start, y_end)
	for y in range(y_min, y_max + 1):
		_carve_tile(dungeon, x, y)

func _tunnel_between(dungeon: MapData, start: Vector2i, end: Vector2i) -> void:
	if _rng.randf() < 0.5:
		_tunnel_horizontal(dungeon, start.y, start.x, end.x)
		_tunnel_vertical(dungeon, end.x, start.y, end.y)
	else:
		_tunnel_vertical(dungeon, start.x, start.y, end.y)
		_tunnel_horizontal(dungeon, end.y, start.x, end.x)

func _place_entities(dungeon: MapData, room: Rect2i) -> void:
	var number_of_monsters: int = _rng.randi_range(0, max_monsters_per_room)

	for _i in number_of_monsters:
		var x: int = _rng.randi_range(room.position.x + 1, room.end.x - 1)
		var y: int = _rng.randi_range(room.position.y + 1, room.end.y - 1)
		var new_entity_position := Vector2i(x, y)

		var can_place = true
		for entity in dungeon.entities:
			if entity.grid_position == new_entity_position:
				can_place = false
				break

		if can_place:
			var new_entity: Entity
			if _rng.randf() < 0.8:
				new_entity = Entity.new(new_entity_position, entity_types.orc)
			else:
				new_entity = Entity.new(new_entity_position, entity_types.troll)
			dungeon.entities.append(new_entity)

func generate_dungeon(player: Entity) -> MapData: ## generate the dungeon
	var dungeon := MapData.new(map_width, map_height)
	dungeon.entities.append(player)
	var rooms: Array[Rect2i] = []

	for _try_room in max_rooms:
		var room_width: int = _rng.randi_range(room_min_size, room_max_size) ## generate the room width based on the min and max parameters
		var room_height: int = _rng.randi_range(room_min_size, room_max_size) ## generate the room height based on the min and max parameters

		var x: int = _rng.randi_range(0, dungeon.width - room_width - 1)
		var y: int = _rng.randi_range(0, dungeon.height - room_height - 1)

		var new_room := Rect2i(x, y, room_width, room_height) ## Create a rectangle at the x,y coordinates with the room width and height

		var has_intersections := false

		for room in rooms:
			# Rect2i.intersects() checks for overlapping points. In order to allow bordering rooms one room is shrunk.
			if room.intersects(new_room.grow(-1)):
				has_intersections = true
				break
		if has_intersections:
			continue

		_carve_room(dungeon, new_room)

		if rooms.is_empty():
			player.grid_position = new_room.get_center()
		else:
			_tunnel_between(dungeon, rooms.back().get_center(), new_room.get_center())

		_place_entities(dungeon, new_room)
		rooms.append(new_room)
	return dungeon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_rng.randomize()

	pass # Replace with function body.
