class_name JumpPlayerState
extends BasePlayerState


func enter(player: Player) -> void:
	player.velocity.y = player.JUMP_VELOCITY
	# Preserve current horizontal velocity if there's no input (feels better
	# than a hard stop), otherwise push toward the input direction.
	if player.move_direction.length() > 0.0:
		player.velocity.x = player.move_direction.x * player.RUN_SPEED
		player.velocity.z = player.move_direction.z * player.RUN_SPEED
	player.jump_count += 1

func pre_update(player: Player) -> void:
	player.change_state_to(PlayerStates.FALL)
