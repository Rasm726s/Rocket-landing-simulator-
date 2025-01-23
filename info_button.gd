extends Button

func _on_pressed():
	print("Info button was pressed!")  # Debugging message
	get_tree().change_scene_to_file("res://info_screen.tscn")
