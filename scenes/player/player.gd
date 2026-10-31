extends CharacterBody2D

# Movement settings
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Gravity from Godot's project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:

	# Apply gravity when the player is not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle left and right movement
	var direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * SPEED

	# Apply movement and collision detection
	move_and_slide()
