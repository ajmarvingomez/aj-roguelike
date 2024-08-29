class_name Entity
extends Sprite2D
## Defines the base entity of the game
##
##
## @tutorial: https://selinadev.github.io/06-rogueliketutorial-02/

var grid_position: Vector2i: ## Defines our Grid Position
    set(value):
        grid_position = value ## set grid_position to the value
        position = Grid.grid_to_world(grid_position) ## Translate the integer to the world's grid

func _init(start_position: Vector2i, entity_definition: EntityDefinition) -> void:
    centered = false ## Set the window position to Top Left
    grid_position = start_position ## Set the grid position to the start position
    texture = entity_definition.texture ## Take the texture from the entity_definition
    modulate = entity_definition.color ## Use the color of the entity_definition

func move(move_offset: Vector2i):
    grid_position += move_offset
