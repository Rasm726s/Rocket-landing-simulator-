extends Node2D

@onready var position_value: Label = $HUD/VBoxContainer/HBoxContainer/PositionValue
@onready var thrust_value: Label = $HUD/VBoxContainer/HBoxContainer2/ThrustValue
@onready var rocket: Node2D = $Rocket/Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position_value.text = str(rocket.position)
