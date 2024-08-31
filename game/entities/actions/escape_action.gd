class_name EscapeAction
extends Action
## Quits the game
##
## Allows player to exit the game.

func perform() -> void:
    entity.get_tree().quit()