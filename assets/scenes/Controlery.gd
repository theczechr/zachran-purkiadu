extends KinematicBody2D

#onready var minihra = load("res://minigames/controllers/Controllers.tscn")
var state = false
var done = false

func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
		#print("zamcknute EEEEEEEEE")
		get_tree().change_scene("res://minigames/controllers/Controllers.tscn")
		#print("zmena sceny -------------------")
		done = true


func _on_Area2D_body_entered(body):
	if done == false: 
		body.set("show_prompt", true)
		state = true
		#print("level 3 state je true *---------------")

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
	#print("level 3 state je false *------------")
