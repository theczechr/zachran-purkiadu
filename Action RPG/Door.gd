extends CollisionShape2D

export (String, FILE) var NEXT_LEVEL : String = ""



func _on_Door_body_entered(body):
	print(get_tree().change_scene("res://Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn"))
	if body.is_in_group("Player") and NEXT_LEVEL != "":
		get_tree().change_scene("res://Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
