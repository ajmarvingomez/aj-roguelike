class_name BumpAction
extends ActionWithDirection
## Checks adjacent space and performs appropriate action

func perform() -> bool:
	var destination := get_destination()

	if get_target_actor():
		return MeleeAction.new(entity, offset.x, offset.y).perform()
	else:
		return MovementAction.new(entity, offset.x, offset.y).perform()
