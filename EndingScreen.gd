extends Control

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().quit()

