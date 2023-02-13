extends Control

var _texture1 = load("res://assets/sprites/packa-hore.png")
var _texture2 = load("res://assets/sprites/packa-dole1.png")
var _texture_toggle: int = 1
onready var texture_button = $NinePatchRect/HBoxContainer/TextureButton
onready var texture_button2 = $NinePatchRect/HBoxContainer/TextureButton2
onready var texture_button3 = $NinePatchRect/HBoxContainer/TextureButton3
onready var texture_button4 = $NinePatchRect/HBoxContainer/TextureButton4
onready var texture_button5 = $NinePatchRect/HBoxContainer/TextureButton5

var state1 = 0
var state2 = 0
var state3 = 0
var state4 = 0
var state5 = 0


func _process(delta):
	if(state1 == 0 and state2 == 1 and state3 == 1 and state4 == 0 and state5 == 1):
		get_tree().change_scene("res://Level3_uhaseno.tscn")
func _on_TextureButton_pressed() -> void:
	if _texture_toggle == 1:
		texture_button.texture_pressed = _texture2
		texture_button.texture_normal = _texture1
		_texture_toggle = 2
		state1 = 0
	else:
		texture_button.texture_pressed = _texture1
		texture_button.texture_normal = _texture2
		_texture_toggle = 1
		state1 = 1


func _on_TextureButton2_pressed():
	if _texture_toggle == 1:
		texture_button2.texture_pressed = _texture2
		texture_button2.texture_normal = _texture1
		_texture_toggle = 2
		state2 = 0
	else:
		texture_button2.texture_pressed = _texture1
		texture_button2.texture_normal = _texture2
		_texture_toggle = 1
		state2 = 1


func _on_TextureButton3_pressed():
	if _texture_toggle == 1:
		texture_button3.texture_pressed = _texture2
		texture_button3.texture_normal = _texture1
		_texture_toggle = 2
		state3 = 0
	else:
		texture_button3.texture_pressed = _texture1
		texture_button3.texture_normal = _texture2
		_texture_toggle = 1
		state3 = 1


func _on_TextureButton4_pressed():
	if _texture_toggle == 1:
		texture_button4.texture_pressed = _texture2
		texture_button4.texture_normal = _texture1
		_texture_toggle = 2
		state4 = 0
	else:
		texture_button4.texture_pressed = _texture1
		texture_button4.texture_normal = _texture2
		_texture_toggle = 1
		state4 = 1

func _on_TextureButton5_pressed():
	if _texture_toggle == 1:
		texture_button5.texture_pressed = _texture2
		texture_button5.texture_normal = _texture1
		_texture_toggle = 2
		state5 = 0
	else:
		texture_button5.texture_pressed = _texture1
		texture_button5.texture_normal = _texture2
		_texture_toggle = 1
		state5 = 1
