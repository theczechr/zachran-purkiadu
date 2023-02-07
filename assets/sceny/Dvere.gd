extends KinematicBody2D
export (String, FILE) var NEXT_LEVEL : String = "Level"
var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			print("DONE")
			get_tree().change_scene("res://Chodba.tscn")


func _on_Interacteble_body_entered(body):
	print("Press E to enter")
	if body.is_in_group("Player") and NEXT_LEVEL != "":
		state = true

func _on_Interacteble_body_exited(body):
	print("exited")
	state = false
