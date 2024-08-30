class_name Map
extends Node2D

var map_data: MapData

@onready var dungeon_generator: DungeonGenerator = $DungeonGenerator ## create a new instance of the dungeon generator class

# Called when the node enters the scene tree for the first time.
func generate(player: Entity) -> void:
	map_data = dungeon_generator.generate_dungeon(player)
	_place_tiles()

func _place_tiles() -> void:
	for tile in map_data.tiles:
		add_child(tile)
