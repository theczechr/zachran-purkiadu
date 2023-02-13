extends KinematicBody2D

onready var minihra = load("res://Controlery_minihra.tscn")
var state = false
var done = false

func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
		get_tree().change_scene("res://Controlery_minihra.tscn")
		done = true


func _on_Area2D_body_entered(body):
	if done == false: 
		body.set("show_prompt", true)
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
