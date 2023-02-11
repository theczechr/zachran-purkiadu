extends KinematicBody2D
export (String, FILE) var NEXT_LEVEL : String = "Level"
var state = false
var last_use = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			print("DONE")
			if NEXT_LEVEL == "Level" or NEXT_LEVEL == "":
				print("Dveře jsou zamčené")
			else:
				get_tree().change_scene(NEXT_LEVEL)


func _on_Interacteble_body_entered(body):
	print("Press E to enter")
	body.set("show_prompt", true)
	if body.is_in_group("Player") and NEXT_LEVEL != "":
		state = true

func _on_Interacteble_body_exited(body):
	body.set("show_prompt", false)
	print("Exited")
	state = false
