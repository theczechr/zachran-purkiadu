extends KinematicBody2D

var state = false


func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
		pass


func _on_Area2D_body_entered(body):
		body.set("show_prompt", true)
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false