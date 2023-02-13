extends Control

var _credentials = _load_csv()

onready var username : LineEdit = $NinePatchRect/VBoxContainer/UsernameContainer/Username
onready var password : LineEdit = $NinePatchRect/VBoxContainer/PasswordContainer/Password
onready var popup : AcceptDialog = $PopUp

func _ready():
	if SaveGame.save_exists():
		get_tree().change_scene("res://ControlsInfo.tscn")

func _on_LoginButton_pressed() -> void:
	if username.text.empty() or password.text.empty():
		popup.show()
		popup.dialog_text = "Zadej prosím přihlašovací jméno i heslo"
		return
	if username.text in _credentials:
		if password.text != _credentials[username.text]:
			popup.show()
			popup.dialog_text = "Nesprávné heslo"
			return
	else:
		popup.show()
		popup.dialog_text = "Nesprávné přihlašovací jméno"
		return

	GlobalData.username_from_login = username.text
	get_tree().change_scene("res://ControlsInfo.tscn")

func _load_csv():
	var file = File.new()
	var result = {}
	file.open("res://resources/ucastnici.txt", file.READ)
	while !file.eof_reached():
		var line = file.get_csv_line(";")
		result[line[0]] = line[-1]
	file.close()
	return result
