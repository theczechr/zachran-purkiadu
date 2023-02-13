extends Sprite

var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
		if not GlobalData.flash_disk:
			var dialog = Dialogic.start("potrebuju_flash")
			add_child(dialog)
		else:
			var dialog = Dialogic.start("open_dvere")
			add_child(dialog)

func _on_Area2D_body_entered(body):
	body.set("show_prompt", true)
	if body.is_in_group("Player"):
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
