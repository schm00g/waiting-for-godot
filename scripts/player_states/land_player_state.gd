class_name LandPlayerState
extends BasePlayerState

const LAND_TIME := 0.15
const LAND_FRICTION := 4.0

var _time_in_state := 0.0


func enter(player: Player) -> void:
	player.anim_tree.set("parameters/movement/transition_request", "land")
	_time_in_state = 0.0


func pre_update(player: Player) -> void:
	if not player.is_on_floor():
		player.change_state_to(PlayerStates.FALL)
		return

	if _time_in_state >= LAND_TIME:
		if player.move_input.length() > 0.0:
			player.change_state_to(PlayerStates.WALK)
		else:
			player.change_state_to(PlayerStates.IDLE)


func update(player: Player, delta: float) -> void:
	_time_in_state += delta

	# Bleed horizontal speed at a fixed rate. 4.0 units/sec² is gentle enough
	# that a full run doesn't stop dead, but strong enough to kill a fall.
	player.velocity.x = move_toward(player.velocity.x, 0.0, LAND_FRICTION * delta)
	player.velocity.z = move_toward(player.velocity.z, 0.0, LAND_FRICTION * delta)

	player.move_and_slide()
	player.turn_to(player.move_direction, delta)
