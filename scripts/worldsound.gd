class_name WorldSounds
extends Node

@export var footstep_sounds: AudioStream

func _ready() -> void:
	MusicPlayer.play(preload("res://Audio/Music/atmos.mp3"))
