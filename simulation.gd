extends Node2D

# 1 meter = 100 px

#Main components
@onready var rocket: RigidBody2D = $Rocket
@onready var hud: CanvasLayer = $HUD
@onready var gameover_screen: CanvasLayer = $GameoverScreen

# HUD labels
@onready var position_value: Label = $HUD/VBoxContainer/HBoxContainer/PositionValue
@onready var thrust_value: Label = $HUD/VBoxContainer/HBoxContainer2/ThrustValue
@onready var vertical_velocity_value: Label = $HUD/VBoxContainer/HBoxContainer3/VerticalVelocityValue
@onready var horizontal_velocity_value: Label = $HUD/VBoxContainer/HBoxContainer5/HorizontalVelocityValue
@onready var angle_value: Label = $HUD/VBoxContainer/HBoxContainer4/AngleValue
@onready var fuel_value: Label = $HUD/VBoxContainer/HBoxContainer6/FuelValue

#End screen labels
@onready var collision_velocity_value: Label = $GameoverScreen/Panel/VBoxContainer/HBoxContainer/CollisionVelocityValue
@onready var fuel_remaining_value: Label = $GameoverScreen/Panel/VBoxContainer/HBoxContainer2/FuelRemainingValue
@onready var score_value: Label = $GameoverScreen/Panel/VBoxContainer/HBoxContainer3/ScoreValue
@onready var highscore_value: Label = $GameoverScreen/Panel/VBoxContainer/HBoxContainer4/HighscoreValue


func score():
	var total_collision_velocity = rocket.pre_collision_velocity.length()/100
	
	# Constants for calculating the score
	const k=6.25
	const t=0.3
	
	if total_collision_velocity > 2:
		return 0
	return (100-total_collision_velocity*k)+(rocket.fuel_remaining*t)

func update_highscore():
	if score() >= Global.highscore:
		Global.highscore = score()
	return Global.highscore

func _ready() -> void:
	gameover_screen.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	position_value.text = str(snapped(rocket.position.y*-1/100,0.1))
	thrust_value.text = str(snapped(rocket.current_thrust/100,0.1))
	vertical_velocity_value.text = str(snapped(rocket.linear_velocity.y/100,0.1))
	horizontal_velocity_value.text = str(snapped(rocket.linear_velocity.x/100,0.1))
	angle_value.text = str(snapped(rocket.rotation*180/PI,0.1))
	fuel_value.text = str(rocket.fuel_remaining)
	
	if rocket.did_land:
		collision_velocity_value.text = str(snapped(rocket.pre_collision_velocity.length()/100,0.1))
		fuel_remaining_value.text = str(rocket.fuel_remaining)
		score_value.text = str(snapped(score(),0.1))
		highscore_value.text = str(snapped(update_highscore(),0.1))
		await get_tree().create_timer(2.0).timeout
		gameover_screen.show()
