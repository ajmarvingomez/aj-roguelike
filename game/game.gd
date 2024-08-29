class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://assets/definitions/actors/player.tres")


@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities
@onready var map: Map = $Map

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2) ## Start the player in the center of the game window

	player = Entity.new(player_start_pos, player_definition) ## Create a new Entity using the player's position and entity definition

	entities.add_child(player) ## add the player as a child node
	var npc := Entity.new(player_start_pos + Vector2i.RIGHT, player_definition) ## Create an NPC using the players position and definition
	npc.modulate = Color.BLUE ## Color the NPC blue

	entities.add_child(npc) ## add the NPC as a child node
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	var action: Action = event_handler.get_action()
	if action:
		action.perform(self, player)

func get_map_data() -> MapData:
	return map.map_data
