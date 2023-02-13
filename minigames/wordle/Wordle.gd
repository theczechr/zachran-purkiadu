extends Control

func _ready():
	$AspectRatioContainer/line_container.connect("game_over", self, "game_over")

func game_over(word):
	$Label.text = word
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Level4.tscn")
