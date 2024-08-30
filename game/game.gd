class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://assets/definitions/actors/player.tres")


@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities
@onready var map: Map = $Map
@onready var camera: Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	player = Entity.new(Vector2i.ZERO, player_definition) ## Create a new Entity using the player's position and entity definition

	remove_child(camera)
	player.add_child(camera)

	entities.add_child(player) ## add the player as a child node
	map.generate(player)
	map.update_fov(player.grid_position)
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	var action: Action = event_handler.get_action()
	if action:
		var previous_player_position: Vector2i = player.grid_position
		action.perform(self, player)
		if player.grid_position != previous_player_position:
			map.update_fov(player.grid_position)

func get_map_data() -> MapData:
	return map.map_data
