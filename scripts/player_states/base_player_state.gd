class_name BasePlayerState
extends RefCounted

## called when we first enter this state
func enter(player: Player) -> void:
	pass
	
## clled when we exit a state
func exit(player: Player) -> void:
	pass
	
## Called before update is called, allow for state changes
func pre_update(player: Player) -> void:
	pass
	
## called for every physics frame that we're in this state
func update(player: Player, delta: float) -> void:
	pass
