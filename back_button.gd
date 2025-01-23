extends Button

func _on_pressed():
	print("Back button was pressed!")  # Debugging message
	get_tree().change_scene_to_file("res://Start screen.tscn")
