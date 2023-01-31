extends Node

const PORT := "20234"
const SERVER_URL := "http://130.61.30.242:%s" % PORT
const SALT := "robbin"

func _parse_result(result: Array) -> String:
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	return result_body.idToken

func get_progress(username: String, http: HTTPRequest) -> void:
	var rhash := (username + SALT).sha256_text()
	var request = SERVER_URL + "/?username=" + username.http_escape() + "&hash=" + rhash.http_escape()
	
	http.request(request, [], false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as 	Array
	if result[1] == 200:
		return _parse_result(result)
		#current_token = _get_token_id_from_result(result)

func set_progress(username: String, progress: String, http: HTTPRequest) -> void:
	var rhash := (username + progress + SALT).sha256_text()
	var request = SERVER_URL + "/?username=" + username.http_escape() + "&hash=" + rhash.http_escape() + "&progress=" + progress.http_escape()
	
	http.request(request, [], false, HTTPClient.METHOD_PUT)
	var result := yield(http, "request_completed") as 	Array
	if result[1] == 200:
		return _parse_result(result)
		#current_token = _get_token_id_from_result(result)