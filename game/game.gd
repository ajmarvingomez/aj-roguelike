class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://assets/definitions/actors/entity_definition_player.tres")

@onready var player: Entity
@onready var input_handler: InputHandler = $InputHandler
@onready var map: Map = $Map
@onready var camera: Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	player = Entity.new(null,Vector2i.ZERO, player_definition) ## Create a new Entity using the player's position and entity definition

	remove_child(camera)
	player.add_child(camera)
	map.generate(player)
	map.update_fov(player.grid_position)
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	var action: Action = input_handler.get_action()
	if action:
		var previous_player_position: Vector2i = player.grid_position
		action.perform()
		_handle_enemy_turns()
		map.update_fov(player.grid_position)

func _handle_enemy_turns() -> void:
	for entity in get_map_data().entities:
		if entity == player:
			continue
		print("The %s wonders when it will get to take a real turn" % entity.get_entity_name())

func get_map_data() -> MapData:
	return map.map_data
