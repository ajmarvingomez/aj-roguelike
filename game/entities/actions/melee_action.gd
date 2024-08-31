class_name MeleeAction
extends ActionWithDirection
## Controls attacks

func perform() -> void:
    var destination := Vector2i(entity.grid_position + offset)

    var target: Entity = get_blocking_entity_at_destination()

    if not target:
        return
    print("You kick the %s, much to its annoyance" % target.get_entity_name())