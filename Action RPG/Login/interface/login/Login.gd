extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $LoginContainer/UserContainer/username
onready var password : LineEdit = $LoginContainer/PassContainer/password
onready var notification : Label = $Notification
onready var Firebase = $Firebase

func _on_LoginButton_pressed() -> void:
	if username.text.empty() or password.text.empty():
		notification.text = "Please, enter your username and password"
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
