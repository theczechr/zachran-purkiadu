extends Control

var _save = SaveGame

func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		if SaveGame.save_exists():
			get_tree().change_scene("res://EmptySceen.tscn")
		else:
			get_tree().change_scene("res://Level1.tscn")
