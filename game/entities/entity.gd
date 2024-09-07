class_name Entity
extends Sprite2D
## Defines the base entity of the game
##
##
## @tutorial: https://selinadev.github.io/06-rogueliketutorial-02/

enum AIType {NONE, HOSTILE}
enum EntityType {CORPSE, ITEM, ACTOR}

var type: EntityType:
	set(value):
		type = value
		z_index = type

var fighter_component: FighterComponent
var ai_component: BaseAIComponent
var consumable_component: ConsumableComponent
var inventory_component: InventoryComponent

var _definition: EntityDefinition
var entity_name: String
var blocks_movement: bool
var map_data: MapData

func is_blocking_movement() -> bool:
	return blocks_movement

func get_entity_name() -> String:
	return entity_name

func set_entity_type(entity_definition: EntityDefinition) -> void:
	_definition = entity_definition
	type = _definition.type
	blocks_movement = _definition.blocks_movement
	entity_name = _definition.entity_name
	texture = entity_definition.texture
	modulate = entity_definition.color

	match entity_definition.ai_type:
		AIType.HOSTILE:
			ai_component = HostileEnemyAIComponent.new()
			add_child(ai_component)
	if entity_definition.fighter_definition:
		fighter_component = FighterComponent.new(entity_definition.fighter_definition)
		add_child(fighter_component)

	if entity_definition.consumable_definition:
		if entity_definition.consumable_definition is HealingConsumableComponentDefinition:
			consumable_component = HealingConsumableComponent.new(entity_definition.consumable_definition)
			add_child(consumable_component)

	if entity_definition.inventory_capacity > 0:
		inventory_component = InventoryComponent.new(entity_definition.inventory_capacity)
		add_child(inventory_component)

var grid_position: Vector2i: ## Defines our Grid Position
	set(value):
		grid_position = value ## set grid_position to the value
		position = Grid.grid_to_world(grid_position) ## Translate the integer to the world's grid

func _init(map_data: MapData, start_position: Vector2i, entity_definition: EntityDefinition) -> void:
	centered = false ## Set the window position to Top Left
	grid_position = start_position ## Set the grid position to the start position
	self.map_data = map_data
	set_entity_type(entity_definition)

func move(move_offset: Vector2i) -> void:
	map_data.unregister_blocking_entity(self)
	grid_position += move_offset
	map_data.register_blocking_entity(self)

func is_alive() -> bool:
	return ai_component != null
