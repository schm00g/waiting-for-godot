class_name IdlePlayerState
extends BasePlayerState


func enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "idle")


func pre_update(player: Player) -> void:
	if not player.is_on_floor():
		return

	elif player.move_input.length() > 0.0:
		player.change_state_to(PlayerStates.WALK)

	elif Input.is_action_just_pressed("ui_accept"):
		player.change_state_to(PlayerStates.JUMP)
		
	elif Input.is_action_just_pressed("roll"):
		player.change_state_to(PlayerStates.ROLL)


func update(player: Player, delta: float) -> void:
	# Hard-stop horizontal movement. We keep velocity.y so gravity still
	# applies and the character doesn't float.
	player.velocity.x = 0.0
	player.velocity.z = 0.0

	# Apply gravity so is_on_floor() stays correct and we don't hover.
	player.velocity.y += player.get_gravity().y * delta
	if player.is_on_floor() and player.velocity.y < 0.0:
		player.velocity.y = 0.0
	player.move_and_slide()
