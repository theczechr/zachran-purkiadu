extends KinematicBody2D

#var player = load("res://player/Player.gd")
var state = false

func _unhandled_input(event):
	if (Input.is_action_just_pressed("interact") and state):
			#print("DONE")
			get_node("AnimatedSprite").queue_free()
			get_node("CollisionShape2D").queue_free()
			get_node("Area2D/interakce").queue_free()

func _on_Area2D_body_entered(body):
	print("Press E to extinguish the fire")
	#player.show_prompt = true
	if body.is_in_group("Player"):
		state = true

func _on_Area2D_body_exited(body):
	#print("Exited")
	#player.show_prompt = false
	state = false
