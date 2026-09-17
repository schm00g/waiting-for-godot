extends Area3D

@export var next_level_path: String

func _ready() -> void:
	# ONE_SHOT so a double-trigger during the transition can't fire twice.
	body_entered.connect(_on_body_entered, CONNECT_ONE_SHOT)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var current_path := get_tree().current_scene.scene_file_path
		var level_number := current_path.get_file().get_basename().trim_prefix("level_").to_int()
		var next_level_path =  "res://Scenes/level_%d.tscn" % (level_number + 1)
		get_tree().change_scene_to_file.call_deferred(next_level_path)

func _on_area_entered(_area: Area3D) -> void:
	pass # Replace with function body.
