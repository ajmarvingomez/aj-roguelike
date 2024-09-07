class_name InventoryMenu
extends CanvasLayer

signal item_selected(item)

const inventory_menu_item_scene := preload("res://game/gui/InventoryMenu/inventory_menu_item.tscn")

@onready var inventory_list: VBoxContainer = $"%InventoryList"
@onready var title_label: Label = $"%TitleLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.

func button_pressed(item: Entity = null) -> void:
	item_selected.emit(item)
	queue_free()

func _register_item(index: int, item: Entity) -> void:
	var item_button: Button = inventory_menu_item_scene.instantiate() ## Create new inventory Item scene

	item_button.text = "(%s) %s" % [String.chr("a".unicode_at(0) + index), item.get_entity_name()] ## (a) Healing Potion
	var shortcut_event := InputEventKey.new() ## Create a new input
	shortcut_event.keycode = KEY_A + index ## add key
	item_button.shortcut = Shortcut.new()
	item_button.shortcut.events = [shortcut_event]
	item_button.pressed.connect(button_pressed.bind(item))
	inventory_list.add_child(item_button)

func build(title_text: String, inventory: InventoryComponent) -> void:
	if inventory.items.is_empty() or inventory == null:
		button_pressed.call_deferred()
		MessageLog.send_message("No items in inventory.", GameColors.IMPOSSIBLE)
		return
	title_label.text = title_text
	for i in inventory.items.size():
		_register_item(i, inventory.items[i])
	inventory_list.get_child(0).grab_focus()
	show()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_back"):
		item_selected.emit(null)
		queue_free()
func _process(delta):
	pass
