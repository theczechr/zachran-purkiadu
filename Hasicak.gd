extends KinematicBody2D

var inventory: Inventory

var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			get_node("AnimatedSprite").hide()
			get_node("CollisionShape2D").disabled = true
			
			inventory.add_item("extinguisher")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		state = true

func _on_Area2D_body_exited(body):
	state = false
