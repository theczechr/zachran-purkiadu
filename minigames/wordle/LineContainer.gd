extends VBoxContainer

var file
var file_dir = "res://assets/5_letter_words.json"
var data

var today_word

var line_active = 0

signal game_over

func _ready():
	randomize()
	load_data(file_dir) 
	today_word = random_word()
	
	get_child(line_active).line_status = true
	connect_to_line()
	print(today_word)

func load_data(dir):
	file = File.new()
	file.open(dir, file.READ)
	data = parse_json(file.get_as_text())
	
func random_word():
	var random_id = randi() % data.size()
	var new_word = data[random_id]["word"].to_upper()
	return new_word


func connect_to_line():
	for i in range(get_child_count()):
		get_child(i).connect("word_to_container", self, "check_word")
		

func check_word(word):
	get_child(line_active).line_status = false
	print("checkword ", word)
	check_letter(word)
	if word == today_word:
		emit_signal("game_over", today_word, true)
		print("win")
	else:
		for i in range(data.size()):
			if word == data[i]["word"].to_upper():
				print("valid")
				

func check_letter(word):
	var temp_word:String = today_word
	
	for i in range(today_word.length()):
		if word[i] == today_word[i]:
			get_child(line_active).get_child(i).change_status(2)
			temp_word.erase(temp_word.find(word[i]), 1)
		else:
			if word[i] in temp_word:
				get_child(line_active).get_child(i).change_status(3)
				temp_word.erase(temp_word.find(word[i]), 1)
			else:
				get_child(line_active).get_child(i).change_status(1)
	
	for i in range(today_word.length()):
		yield(get_tree().create_timer(0.1), "timeout")
	
	change_line()
		
func change_line():
	if line_active < get_child_count() - 1:
		line_active += 1
		get_child(line_active).line_status = true
	else:
		print("game over")
		emit_signal("game_over", today_word, false)
		
