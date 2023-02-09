extends KinematicBody2D

var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			print("DONE")
			get_node("AnimatedSprite").queue_free()
			get_node("CollisionShape2D").queue_free()
			get_node("Area2D/interakce").queue_free()

func _on_Area2D_body_entered(body):
	print("Press E to extinguish the fire")
	if body.is_in_group("Player"):
		state = true

func _on_Area2D_body_exited(body):
	print("Exited")
	state = false
