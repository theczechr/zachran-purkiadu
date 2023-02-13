extends Node2D
var packed_scene = PackedScene.new()
var _save : SaveGame
var loaded := load("ControlsInfo.tscn")
func _ready():
	var my_scene
	var lo = loaded.instance()
	#print("went through empty scene")
	_save = SaveGame.load_savegame() as SaveGame
	
	if ResourceLoader.exists("user://Level1.tscn") && _save.character.level == 1:
		# Load the PackedScene resource
		var packed_scene = load("user://Level1.tscn")
		# Instance the scene
		my_scene = packed_scene.instance()
		add_child(my_scene)
		#print("level 1 loaded")
	if ResourceLoader.exists("user://Level2.tscn") && _save.character.level == 2:
		# Load the PackedScene resource
		var packed_scene = load("user://Level2.tscn")
		# Instance the scene
		my_scene = packed_scene.instance()
		add_child(my_scene)
		#print("level 2 loaded")
	if ResourceLoader.exists("user://Level3.tscn") && _save.character.level == 4:
		# Load the PackedScene resource
		var packed_scene = load("user://Level3.tscn")
		# Instance the scene
		my_scene = packed_scene.instance()
		add_child(my_scene)
		#print("level 3 loaded")
	if ResourceLoader.exists("user://Level4.tscn") && _save.character.level == 3:
		# Load the PackedScene resource
		var packed_scene = load("user://Level4.tscn")
		# Instance the scene
		my_scene = packed_scene.instance()
		add_child(my_scene)
		#print("level 4 loaded")
	if ResourceLoader.exists("user://Level3_uhaseno.tscn") && _save.character.level == 5:
		# Load the PackedScene resource
		var packed_scene = load("user://Level3_uhaseno.tscn")
		# Instance the scene
		my_scene = packed_scene.instance()
		add_child(my_scene)
		#print("level 3 uhaseno loaded")
	if lo.loaded_scene:
		#print("loaded scene state:", lo.loaded_scene)
		var dialog = Dialogic.start(str(my_scene.get_name()))
		add_child(dialog)
		#print(str(my_scene.get_name()) + "_entered in EmptySceen.gd")
		Dialogic.set_variable(((str(get_tree().get_current_scene().get_name()) + "_entered")), "true")

