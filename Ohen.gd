extends KinematicBody2D
onready var player = get_tree().get_root().find_node("Player")
var state = false

func _unhandled_input(event):
	if (Input.is_action_just_pressed("interact") and state):
			#print("DONE")
			get_node("AnimatedSprite").queue_free()
			get_node("CollisionShape2D").queue_free()
			get_node("Area2D/interakce").queue_free()

func _on_Area2D_body_entered(body):
	print("Press E to extinguish the fire")
	if body.is_in_group("Player"):
		body.set("show_prompt", true)
		state = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):	
		body.set("show_prompt", false)
		print("Exited")
		state = false
