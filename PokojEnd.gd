extends Node2D


func _ready():
		var dialog = Dialogic.start(str(get_tree().get_current_scene().get_name()))
		add_child(dialog)
