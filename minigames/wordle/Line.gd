extends HBoxContainer

export var line_status = false

var line_active = 0

var word_input: String

signal word_to_container

func _input(event):
	if line_status == true:
		if (
			event.is_action("enter") and 
			word_input.length() == get_child_count()
		):
			#print("enter")
			emit_signal("word_to_container", word_input)
			update_label()
		elif (
			event.is_action("backspace") and 
			word_input.length() > 0 and 
			event.is_echo() == false and 
			event.is_pressed()
			):
			word_input.erase(word_input.length() - 1, 1)
			update_label()
			#print("backspace")
		elif (event is InputEventKey and 
		event.is_echo() == false and 
		event.is_pressed() and 
		event.as_text().length() == 1 and 
		word_input.length() < get_child_count()):
			word_input += event.as_text()
			update_label()
			get_child(word_input.length() -1).pop_anim()
			#print(word_input)

func update_label():
	for i in range(get_child_count()):
		get_child(i).text = ""
	
	for i in range(word_input.length()):
		get_child(i).text = word_input[i]
