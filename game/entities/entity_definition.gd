class_name EntityDefinition
extends Resource

@export_category("Visuals") ## Creates "Visuals" Category in Godot
@export var entity_name: String = "Unnamed Entity"
@export var texture: AtlasTexture ## We're using AtlasTexture and a sheet
@export_color_no_alpha var color: Color = Color.WHITE

@export_category("Mechanics")
@export var blocks_movement: bool = true
@export var type: Entity.EntityType = Entity.EntityType.ACTOR

@export_category("Components")
@export var fighter_definition: FighterComponentDefinition
@export var ai_type: Entity.AIType
@export var consumable_definition: ConsumableComponentDefinition
@export var inventory_capacity: int = 0
