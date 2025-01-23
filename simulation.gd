extends Node2D

# 1 meter = 100 px

@onready var position_value: Label = $HUD/VBoxContainer/HBoxContainer/PositionValue
@onready var thrust_value: Label = $HUD/VBoxContainer/HBoxContainer2/ThrustValue
@onready var velocity_value: Label = $HUD/VBoxContainer/HBoxContainer3/VelocityValue
@onready var rocket: RigidBody2D = $Rocket

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position_value.text = str(rocket.position.y*-1/100)
	thrust_value.text = str(rocket.current_thrust/100)
	velocity_value.text = str(rocket.linear_velocity)
