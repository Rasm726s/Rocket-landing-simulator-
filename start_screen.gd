extends Node2D

func _on_infobutton_pressed() -> void:
	print("Info button was pressed!")  #Skrifter scene til infor screen
	get_tree().change_scene_to_file("res://info_screen.tscn")
	
	

func _on_startbutton_pressed() -> void:
	print("Info button was pressed!")  #Skrifter scene til infor screen
	get_tree().change_scene_to_file("res://simulation.tscn")
	


func _on_quitbutton_pressed() -> void:
	print("Quit button was pressed!")
	get_tree().quit()
