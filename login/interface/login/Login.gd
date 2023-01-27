extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer2/Username/LineEdit
onready var password : LineEdit = $Container/VBoxContainer2/Password/LineEdit
onready var notification : Label = $Container/Notification


func _on_LoginButton_pressed() -> void:
	if username.text.empty():
		notification.text = "Please, enter your username and password"
		return
	Firebase.get_progress(username.text, http)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
	else:
		notification.text = "Sign in sucessful!"
