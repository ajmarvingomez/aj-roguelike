class_name BumpAction
extends ActionWithDirection
## Checks adjacent space and performs appropriate action

func perform() -> void:
    var destination := get_destination()

    if get_map_data().get_blocking_entity_at_location(destination):
        MeleeAction.new(entity, offset.x, offset.y).perform()
    else:
        MovementAction.new(entity, offset.x, offset.y).perform()