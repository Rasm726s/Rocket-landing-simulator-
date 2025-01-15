extends CharacterBody2D

# Movement constants
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_ROTATION_SPEED = 10
const ROTATION_INCREMENT = 2
const MAX_THRUST = 500.0
const THRUST_INCREMENT = 50

# Variables for movement
var current_thrust: float = 0.0
var current_rotation: float = 0.0

# Define a spawn position variable
var spawn_position: Vector2 = Vector2(0, -200)  # Replace with your desired coordinates

func _ready() -> void:
	# Set the initial position of the character to the spawn position
	position = spawn_position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
