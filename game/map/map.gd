class_name Map
extends Node2D

@export var fov_radius: int = 8

var map_data: MapData

@onready var dungeon_generator: DungeonGenerator = $DungeonGenerator ## create a new instance of the dungeon generator class
@onready var field_of_view: FieldOfView = $FieldOfView


func update_fov(player_position: Vector2i) -> void:
	field_of_view.update_fov(map_data, player_position, fov_radius)
# Called when the node enters the scene tree for the first time.
func generate(player: Entity) -> void:
	map_data = dungeon_generator.generate_dungeon(player)
	_place_tiles()

func _place_tiles() -> void:
	for tile in map_data.tiles:
		add_child(tile)
