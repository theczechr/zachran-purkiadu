extends KinematicBody2D

signal pickup_hasicak

var state = false
func _unhandled_input(event):
	if Input.is_key_pressed(KEY_E) and state:
		emit_signal("pickup_hasicak")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.set("show_prompt", true)
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
