extends BaseInputHandler

func get_action(player: Entity) -> Action:
	var action: Action

	if Input.is_action_just_pressed("ui_cancel"):
		action = EscapeAction.new(player)
	return action
