extends CharacterBody2D

# Stores recorded player positions
var recorded_positions: Array[Vector2] = []

# Tracks current replay position
var replay_index: int = 0

# Checks whether Ghost is replaying
var is_replaying: bool = false


func start_replay(positions: Array[Vector2]) -> void:
	recorded_positions = positions.duplicate()
	replay_index = 0
	is_replaying = true
	visible = true


func _physics_process(_delta: float) -> void:

	if not is_replaying:
		return

	# Stop when recording is complete
	if replay_index >= recorded_positions.size():
		is_replaying = false
		return

	# Move Ghost to the next recorded position
	global_position = recorded_positions[replay_index]

	replay_index += 1
