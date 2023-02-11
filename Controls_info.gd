extends Control

func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://Game.tscn")
	
