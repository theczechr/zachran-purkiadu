extends KinematicBody2D

signal pickup_flash_disk

func _ready():
	if GlobalData.flash_disk:
		$Sprite.hide()
		$Area2D.hide()
		$Collision.hide()

var state = false
func _unhandled_input(event):
	if Input.is_key_pressed(KEY_E) and state and GlobalData.flash_disk == false:
		emit_signal("pickup_flash_disk")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and GlobalData.flash_disk == false:
		body.set("show_prompt", true)
		state = true

func _on_Area2D_body_exited(body):
	body.set("show_prompt", false)
	state = false
