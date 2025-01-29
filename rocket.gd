extends RigidBody2D

# Movement constants
const MAX_ROTATION_SPEED = 18
const ROTATION_SPEED = .008
const MAX_THRUST = 3.0 * 100
const THRUST_INCREMENT = 0.25 * 100


# Variables for movement
var current_thrust: float = 0.0
var current_rotation: float = 0.0

# Define a spawn position variable
var spawn_position: Vector2 = Vector2(0, -10 * 100)  # Replace with your desired coordinates

# Variables for landing
var pre_collision_velocity : Vector2
var did_land : bool = false
var can_control : bool = true

# Variable for fuel
var fuel_remaining : int = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	position = spawn_position
	print(pre_collision_velocity)
	$Crewmate.visible = true
	$DeadCrewmate.visible = false
	$CrewmateCollisionShape.disabled = true
	$DeadCrewmateCollisionShape.disabled = false


# Called when the rocket hits the moons surface
func _on_body_entered(body: Node) -> void:
	if !did_land:
		var message = str(pre_collision_velocity/100)
		print (message)
		did_land = true
		can_control = false
		current_thrust = 0

	if pre_collision_velocity.length()/100 >= 2:
		print(pre_collision_velocity.length())
		$Crewmate.visible = false
		$DeadCrewmate.visible = true
		$CrewmateCollisionShape.disabled = true
		$DeadCrewmateCollisionShape.disabled = false

func _on_timer_timeout() -> void:
	if fuel_remaining >= 0:
		fuel_remaining -= current_thrust / THRUST_INCREMENT * 0.15

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if !did_land:
		pre_collision_velocity = linear_velocity
	
	if fuel_remaining <= 1:
		can_control = false
		fuel_remaining = 0
		current_thrust = 0
	
	if can_control:
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
