class_name FallPlayerState
extends BasePlayerState


func enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "fall")


func pre_update(player: Player) -> void:
	if player.is_on_floor():
		player.jump_count = 0
		player.change_state_to(PlayerStates.IDLE)
		
	elif Input.is_action_just_pressed("ui_accept") and player.jump_count < player.MAX_JUMPS:
		player.change_state_to(PlayerStates.JUMP)


func update(player: Player, delta: float) -> void:
	var move := player.move_direction * player.move_input.length()

	player.velocity += player.get_gravity() * delta
	player.update_velocity_using_direction(move)
	player.move_and_slide()
	player.turn_to(move)
