class_name Entity
extends Sprite2D
## Defines the base entity of the game
##
##
## @tutorial: https://selinadev.github.io/06-rogueliketutorial-02/

var _definition: EntityDefinition
var map_data: MapData

func is_blocking_movement() -> bool:
    return _definition.is_blocking_movement

func get_entity_name() -> String:
    return _definition.name

func set_entity_type(entity_definition: EntityDefinition) -> void:
    _definition = entity_definition
    texture = entity_definition.texture
    modulate = entity_definition.color

var grid_position: Vector2i: ## Defines our Grid Position
    set(value):
        grid_position = value ## set grid_position to the value
        position = Grid.grid_to_world(grid_position) ## Translate the integer to the world's grid

func _init(map_data: MapData, start_position: Vector2i, entity_definition: EntityDefinition) -> void:
    centered = false ## Set the window position to Top Left
    grid_position = start_position ## Set the grid position to the start position
    self.map_data = map_data
    set_entity_type(entity_definition)

func move(move_offset: Vector2i):
    grid_position += move_offset
