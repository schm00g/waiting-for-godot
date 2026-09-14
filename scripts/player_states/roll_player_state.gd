class_name RollPlayerState
extends BasePlayerState
 
 
func enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "roll")
	
	var forward := -player.global_transform.basis.z
	player.velocity = player.velocity.move_toward(Vector3.ZERO, player.base_speed)
	player.velocity.x = forward.x * player.ROLL_SPEED
	player.velocity.z = forward.z * player.ROLL_SPEED
 
 
func pre_update(player: Player) -> void:
	if not player.is_on_floor():
		player.change_state_to(PlayerStates.FALL)
		return
 
	var current_position: float = player.anim_tree.get("parameters/movement/current_position")
	var current_length: float = player.anim_tree.get("parameters/movement/current_length")
 
	if current_length > 0.0 and current_position >= current_length - 0.05:
		player.change_state_to(PlayerStates.IDLE)
 
 
func update(player: Player, delta: float) -> void:
	var move := player.move_direction * player.move_input.length()
	
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.ROLL_DECELERATION * delta)
	player.velocity.z = move_toward(player.velocity.z, 0.0, player.ROLL_DECELERATION * delta)
	
	player.update_velocity_using_direction(move)
	player.move_and_slide()
	player.turn_to(move)
 
