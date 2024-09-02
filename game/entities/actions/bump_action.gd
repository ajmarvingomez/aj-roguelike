class_name BumpAction
extends ActionWithDirection
## Checks adjacent space and performs appropriate action

func perform() -> void:
	var destination := get_destination()

	if get_target_actor():
		MeleeAction.new(entity, offset.x, offset.y).perform()
	else:
		MovementAction.new(entity, offset.x, offset.y).perform()
