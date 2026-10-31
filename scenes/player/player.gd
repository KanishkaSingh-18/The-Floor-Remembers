extends CharacterBody2D

# Movement settings
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Load Ghost scene
const GHOST_SCENE = preload("res://scenes/ghost/ghost.tscn")

# Gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Recording variables
var recorded_positions: Array[Vector2] = []
var is_recording: bool = false

# Reference to the currently existing Ghost
var current_ghost: CharacterBody2D = null


func _physics_process(delta: float) -> void:

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movement
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	# Apply movement
	move_and_slide()

	# Toggle recording using R
	if Input.is_action_just_pressed("record"):
		if not is_recording:
			start_recording()
		else:
			stop_recording()

	# Record player's position
	if is_recording:
		recorded_positions.append(global_position)


func start_recording() -> void:

	# Remove previous Ghost if it exists
	if is_instance_valid(current_ghost):
		current_ghost.queue_free()
		current_ghost = null

	# Clear previous recording
	recorded_positions.clear()

	# Start new recording
	is_recording = true

	print("Recording started!")


func stop_recording() -> void:

	is_recording = false

	print("Recording stopped!")

	# Check if positions were recorded
	if recorded_positions.is_empty():
		return

	# Create a new Ghost
	current_ghost = GHOST_SCENE.instantiate()

	# Add Ghost to Main scene
	get_tree().current_scene.add_child(current_ghost)

	# Start Ghost replay
	current_ghost.start_replay(recorded_positions)

	print("Ghost replay started!")
