class_name EscapeAction
extends Action
## Quits the game
##
## Allows player to exit the game.

func perform(game: Game, entity: Entity) -> void:
    game.get_tree().quit()