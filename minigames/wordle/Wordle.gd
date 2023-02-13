extends Control

func _ready():
	$ReferenceRect/line_container.connect("game_over", self, "game_over")

func game_over(word, guessed):
	$ReferenceRect/Label.text = "Odemknuto!" if guessed else "Špatné heslo!"
	$AnimationPlayer.play("fade_in")
	$ReferenceRect/ColorRect3.color = "1e962b" if guessed else "bd1616"
	yield(get_tree().create_timer(4), "timeout")
	if guessed:	
		get_tree().change_scene("res://Level4.tscn")
	else:
		get_tree().reload_current_scene()


func _on_Button_pressed():
	get_tree().change_scene("res://minigames/wordle/info.tscn")
