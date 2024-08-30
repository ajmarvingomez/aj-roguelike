class_name EntityDefinition
extends Resource

@export_category("Visuals") ## Creates "Visuals" Category in Godot
@export var name: String = "Unnamed Entity"
@export var texture: AtlasTexture ## We're using AtlasTexture and a sheet
@export_color_no_alpha var color: Color = Color.WHITE

@export_category("Mechanics")
@export var is_blocking_movement: bool = true
