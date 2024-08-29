class_name EventHandler
extends Node
## Engine for handling events in the game
## @tutorial: https://gameprogrammingpatterns.com/command.html
func get_action() -> Action:
	var action: Action = null

	if Input.is_action_just_pressed("ui_up"):
		action = MovementAction.new(0, -1)
	elif Input.is_action_just_pressed("ui_down"):
		action = MovementAction.new(0, 1)
	elif Input.is_action_just_pressed("ui_left"):
		action = MovementAction.new(-1, 0)
	elif Input.is_action_just_pressed("ui_right"):
		action = MovementAction.new(1, 0)

	if Input.is_action_just_pressed("ui_cancel"):
		action = EscapeAction.new()

	return action
