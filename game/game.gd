class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://assets/definitions/actors/player.tres")


@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities
@onready var map: Map = $Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	player = Entity.new(Vector2i.ZERO, player_definition) ## Create a new Entity using the player's position and entity definition

	var camera: Camera2D = $Camera2D
	remove_child(camera)
	player.add_child(camera)

	entities.add_child(player) ## add the player as a child node
	map.generate(player)
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	var action: Action = event_handler.get_action()
	if action:
		action.perform(self, player)

func get_map_data() -> MapData:
	return map.map_data
