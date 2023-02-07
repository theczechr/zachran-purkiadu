extends KinematicBody2D

var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			print("DONE")
			get_node("AnimatedSprite").hide()
			get_node("CollisionShape2D").disabled = true

func _on_Area2D_body_entered(body):
	print("Press E to extinguish the fire")
	if body.is_in_group("Player"):
		state = true

func _on_Area2D_body_exited(body):
	print("Exited")
	state = false
