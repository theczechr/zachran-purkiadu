extends KinematicBody2D

signal dvere_vstup

export (String, FILE) var NEXT_LEVEL : String = "Level"

var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			if NEXT_LEVEL == "Level" or NEXT_LEVEL == "":
				print("Dveře jsou zamčené")
			else:
				get_tree().change_scene(NEXT_LEVEL)

func _on_Area2D_body_entered(body):
	body.set("show_prompt", true)
	if body.is_in_group("Player") and NEXT_LEVEL != "":
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
