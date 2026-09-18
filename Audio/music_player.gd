extends Node

## Track that should play. Assign in the inspector or set at runtime.
@export var initial_track: AudioStream

## Optional: separate bus so you can duck/mute music independently.
@export var bus := &"Music"

var _player: AudioStreamPlayer


func _ready() -> void:
	# Autoloads are ready before the main scene, so this is a safe place
	# to build the player.
	_player = AudioStreamPlayer.new()
	_player.volume_db = -6.0
	_player.bus = bus
	add_child(_player)
	play(load("res://Audio/Music/atmos.mp3"))


## Start a track. If it's already playing, this is a no-op.
func play(stream: AudioStream) -> void:
	if stream == null:
		return
	if _player.stream == stream and _player.playing:
		return
	_player.stream = stream
	_player.play()


## Change to a different track. Fades out the old one first if requested.
func crossfade_to(stream: AudioStream, _duration: float = 0.5) -> void:
	if stream == null or stream == _player.stream:
		return

	# Simple version: hard cut. For a real crossfade you need a second player.
	_player.stream = stream
	_player.play()


func stop() -> void:
	_player.stop()


func set_volume_db(db: float) -> void:
	_player.volume_db = db
	
	
func is_playing() -> bool:
	return _player.playing


func get_current_stream() -> AudioStream:
	return _player.stream
