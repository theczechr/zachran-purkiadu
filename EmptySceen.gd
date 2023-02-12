extends Node2D

var packed_scene = PackedScene.new()
var _save : SaveGame

func _ready():
	_save = SaveGame.load_savegame() as SaveGame
	
	if ResourceLoader.exists("user://Level1.tscn") && _save.character.level == 1:
		# Load the PackedScene resource
		var packed_scene = load("user://Level1.tscn")
		# Instance the scene
		var my_scene = packed_scene.instance()
		add_child(my_scene)
		print("level 1 loaded")
	if ResourceLoader.exists("user://Level2.tscn") && _save.character.level == 2:
		# Load the PackedScene resource
		var packed_scene = load("user://Level2.tscn")
		# Instance the scene
		var my_scene = packed_scene.instance()
		add_child(my_scene)
		print("level 2 loaded")		
	if ResourceLoader.exists("user://Level3.tscn") && _save.character.level == 3:
		# Load the PackedScene resource
		var packed_scene = load("user://Level3.tscn")
		# Instance the scene
		var my_scene = packed_scene.instance()
		add_child(my_scene)
		print("level 3 loaded")
	if ResourceLoader.exists("user://Level4.tscn") && _save.character.level == 4:
		# Load the PackedScene resource
		var packed_scene = load("user://Level4.tscn")
		# Instance the scene
		var my_scene = packed_scene.instance()
		add_child(my_scene)
		print("level 4 loaded")		
	if ResourceLoader.exists("user://Level5.tscn") && _save.character.level == 5:
		# Load the PackedScene resource
		var packed_scene = load("user://Level5.tscn")
		# Instance the scene
		var my_scene = packed_scene.instance()
		add_child(my_scene)
		print("level 5 loaded")		
