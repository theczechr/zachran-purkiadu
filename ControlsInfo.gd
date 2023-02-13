extends Control

var _save = SaveGame
var loaded_scene = true
func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		if SaveGame.save_exists():
			#print("brudda get to empty sceene ")
			loaded_scene = false
			get_tree().change_scene("res://EmptySceen.tscn")
		else:
			#print("went straight to level one yeah")
			get_tree().change_scene("res://Level1.tscn")
	#print(loaded_scene)
