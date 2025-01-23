extends Button

func _on_start_button_pressed():
	print("Info button was pressed!")  # Debugging message
	get_tree().change_scene_to_file("res://simulation.tscn")
