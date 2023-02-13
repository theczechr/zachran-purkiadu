extends HTTPRequest

const PORT := "20239"
const SERVER_URL := "http://130.61.197.60:%s" % PORT
const SALT := "robbin"

func _parse_result(result: Array) -> String:
	var result_body := JSON.parse(result[3].get_string_from_utf8()).result as Dictionary
	return result_body.idToken

func get_progress(username: String, http: HTTPRequest) -> int:
	var rhash := (username + SALT).sha256_text()
	var request = SERVER_URL + "/?username=" + username.http_escape() + "&hash=" + rhash.http_escape()

	http.request(request, [], false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	print(result)
	var return_value = PoolByteArray(result[3]).get_string_from_utf8()
	#print("get ", int(return_value), ", ", str(return_value), ", ", return_value)

	if result[1] == 200:
		return int(return_value)
	return 0

func set_progress(username: String, progress: String, http: HTTPRequest) -> bool:
	var rhash := (username + progress + SALT).sha256_text()
	var request = SERVER_URL + "/?username=" + username.http_escape() + "&hash=" + rhash.http_escape() + "&progress=" + progress.http_escape()
	http.request(request, [], false, HTTPClient.METHOD_PUT)
	var result := yield(http, "request_completed") as 	Array
	return result[1] == 200

