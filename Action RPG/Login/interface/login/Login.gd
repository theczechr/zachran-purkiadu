extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $LoginContainer/UserContainer/username
onready var password : LineEdit = $LoginContainer/PassContainer/password
onready var notification : Label = $Notification
onready var Firebase = $Firebase
var credentials = _load_csv()

func _on_LoginButton_pressed() -> void:
	if username.text.empty() or password.text.empty():
		notification.text = "Zadej prosím přihlašovací jméno a heslo"
		return
	if username.text in credentials:
		if password.text != credentials[username.text]:
			notification.text = "Nesprávné heslo"
			return
	else:
		notification.text = "Nesprávné přihlašovací údaje"
		return
	GlobalData.current_data["player_id"] = username.text
	GlobalData.save_data(GlobalData.player_file_path)
	#Firebase.get_progress(username.text, http)
	get_tree().change_scene("res://Level_0.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
	else:
		notification.text = "Sign in sucessful!"


func _on_BackButton_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")

func _load_csv():
	var file = File.new()
	var result = {}
	file.open("res://global_data/ucastnici.csv", file.READ)
	while !file.eof_reached():
		var line = file.get_csv_line(";")
		result[line[0]] = line[-1]
	file.close()
	return result
