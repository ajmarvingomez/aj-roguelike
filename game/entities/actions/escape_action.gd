class_name EscapeAction
extends Action
## Quits the game
##
## Allows player to exit the game.

func perform() -> bool:
    entity.get_tree().quit()
    return false