class_name WalkPlayerState
extends BasePlayerState


func enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "walk")


func pre_update(player: Player) -> void:
	var current_speed := player.get_current_speed()

	if Input.is_action_just_pressed("ui_accept"):
		player.change_state_to(PlayerStates.JUMP)

	elif not player.is_on_floor():
		player.change_state_to(PlayerStates.FALL)

	elif player.move_input.length() == 0:
		player.change_state_to(PlayerStates.IDLE)

	elif current_speed > player.RUN_SPEED:
		player.change_state_to(PlayerStates.RUN)
		
	elif Input.is_action_just_pressed("roll"):
		player.change_state_to(PlayerStates.ROLL)


func update(player: Player, delta: float) -> void:
	var move := player.move_direction * player.move_input.length()
	player.update_velocity_using_direction(move)
	player.move_and_slide()
	player.turn_to(move, delta)

	var walk_speed := lerpf(0.5, 1.75, player.get_current_speed() / player.RUN_SPEED)
	player.anim_tree.set("parameters/walk_speed/scale", walk_speed)
