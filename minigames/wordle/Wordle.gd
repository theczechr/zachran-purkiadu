extends Control

func _ready():
	$AspectRatioContainer3/AspectRatioContainer/line_container.connect("game_over", self, "game_over")

func game_over(word, guessed):
	$AspectRatioContainer2/Label.text = word
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(3), "timeout")
	if guessed:
		get_tree().change_scene("res://Level4.tscn")
	else:
		get_tree().reload_current_scene()
