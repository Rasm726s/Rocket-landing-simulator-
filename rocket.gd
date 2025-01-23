extends RigidBody2D

# Movement constants
const MAX_ROTATION_SPEED = 15
const ROTATION_SPEED = .008
const MAX_THRUST = 2.0 * 100
const THRUST_INCREMENT = 0.25 * 100

# Variables for movement
var current_thrust: float = 0.0
var current_rotation: float = 0.0
var thrust_vector = Vector2(0,-1).rotated(rotation) * current_thrust

# Define a spawn position variable
var spawn_position: Vector2 = Vector2(0, -10 * 100)  # Replace with your desired coordinates

# Velocity before collision
var pre_collision_velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = spawn_position

# Called when the rocket hits the moons surface
func _on_body_entered(body: Node) -> void:
	var message = str(pre_collision_velocity)
	print (message)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pre_collision_velocity = linear_velocity
	
	if Input.is_action_pressed("rotate_ccw"):
		if angular_velocity > - MAX_ROTATION_SPEED:
			angular_velocity -= ROTATION_SPEED
	
	if Input.is_action_pressed("rotate_cw"):
		if angular_velocity < MAX_ROTATION_SPEED:
			angular_velocity += ROTATION_SPEED
	
	if Input.is_action_just_pressed("increase_thrust"):
		if current_thrust < MAX_THRUST:
			current_thrust += THRUST_INCREMENT
	
	if Input.is_action_just_pressed("decrease_thrust"):
		if current_thrust > 0:
			current_thrust -= THRUST_INCREMENT

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var thrust_vector = Vector2(0,-1).rotated(rotation) * current_thrust
	state.apply_force(thrust_vector)
	#print(thrust_vector)
	
	#collision_velocity = state.linear_velocity
