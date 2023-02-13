extends KinematicBody2D

signal use_flash_disk

var state = false
func _unhandled_input(event):
	if Input.is_key_pressed(KEY_E) and state:
		emit_signal("use_flash_disk")
		Dialogic.set_variable(("flash_used"), true)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and GlobalData.flash_disk:
		body.set("show_prompt", true)
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
