extends Control

var _save: SaveGame
onready var _player := $PlayerCharacter

var _credentials = _load_csv()

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $NinePatchRect/VBoxContainer/UsernameContainer/Username
onready var password : LineEdit = $NinePatchRect/VBoxContainer/PasswordContainer/Password
onready var popup : AcceptDialog = $PopUp
onready var Firebase = $Firebase

func _on_LoginButton_pressed() -> void:
	if username.text.empty() or password.text.empty():
		popup.show()
		#popup.dialog_text("Zadej prosím přihlašovací jméno a heslo")
		return
	if username.text in _credentials:
		if password.text != _credentials[username.text]:
			popup.show()
			#popup.dialog_text("Nesprávné heslo")
			return
	else:
		popup.show()
		#popup.dialog_text("Nesprávné přihlašovací údaje")
		return
	
#	SaveGame.current_data["player_id"] = username.text
#	SaveGame.save_data(SaveGame.player_file_path)
#	Firebase.get_progress(username.text, http)
	get_tree().change_scene("res://levels/Level-1.tscn")

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		popup.show()
		#popup.dialog_text(response_body.result.error.message.capitalize())
	else:
		popup.show()
		#popup.dialog_text("Přihlášení úspěšné!")

#func _on_BackButton_pressed():
	#get_tree().change_scene("res://Menu/Menu.tscn")
	
func _create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_savegame() as SaveGame
	else:
		_save = SaveGame.new()
		_save.inventory = Inventory.new()
		_save.Character = Character.new()
		_save.global_position = _player.global_position
		
		_save.write_savegame()
		
	_player.global_position = _save.global_position
	_player.stats = _save.character
		
func _save_game() -> void:
	_save.global_position = _player.global_position
	_save.write_savegame()

func _load_csv():
	var file = File.new()
	var result = {}
	file.open("res://ucastnici.csv.txt", file.READ)
	while !file.eof_reached():
		var line = file.get_csv_line(";")
		result[line[0]] = line[-1]
	file.close()
	return result
