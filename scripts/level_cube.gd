extends CSGBox3D

@export var rotation_speed: float = 2.0
@export var float_amplitude: float = 0.2  # How high and low the box moves
@export var float_frequency: float = 2.0  # How fast the up-and-down cycle repeats

var time_passed: float = 0.0
var initial_y: float

func _ready() -> void:
	# Store the starting Y position so the object floats around its original spot
	initial_y = position.y

func _process(delta: float) -> void:
	# 1. Spin the cube
	rotate_y(rotation_speed * delta)
	
	# 2. Float the cube up and down
	time_passed += delta
	position.y = initial_y + sin(time_passed * float_frequency) * float_amplitude
