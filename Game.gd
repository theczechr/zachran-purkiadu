extends Node2D

var _save: SaveGame
var packed_scene = PackedScene.new()
onready var _player := $YSort/PlayerCharacter
onready var _inventory := $UI/Inventory
var _http = load("res://login/Firebase.gd").new()
var loaded := load("ControlsInfo.tscn")

func _ready():
	_create_or_load_save()
	
	get_node("Checkpoint").connect("checkpoint_requested", self, "_checkpoint")
	
	if get_tree().get_current_scene().get_name() == "Level1":
		get_node("YSort/Hasicak").connect("pickup_hasicak", self, "_pickup_hasicak")
	
	if get_tree().get_current_scene().get_name() == "Level2":
		GlobalData.hasicak = false
		_inventory.inventory.remove_item("extinguisher")
		_save_game()
	var lo = loaded.instance()
	if str(get_tree().get_current_scene().get_name()) != "EmptySceen":
		var dialog = Dialogic.start(str(get_tree().get_current_scene().get_name()))
		add_child(dialog)
		print(str(get_tree().get_current_scene().get_name()) + "_entered in game.gd")
		Dialogic.set_variable(((str(get_tree().get_current_scene().get_name()) + "_entered")), "true")

func _create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_savegame() as SaveGame
	else:
		_save = SaveGame.new()
		_save.inventory = Inventory.new()
		_save.character = Character.new()
		_save.character.id = GlobalData.username_from_login
		
		_save.write_savegame()

	_player.stats = _save.character
	_inventory.inventory = _save.inventory
	GlobalData.hasicak = _inventory.inventory.is_item("extinguisher")
	
	_progress_sync()
	
func _checkpoint(progress: int) -> void:
	if progress > _player.stats.level:
		_player.stats.level = progress
		_progress_sync()

func _save_game() -> void:
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("user://" + get_tree().get_current_scene().get_name() + ".tscn", packed_scene)
	_save.write_savegame()

func _progress_sync() -> void:
	_save_game()
	var server_level = yield(_http.get_progress(_player.stats.id, $HTTPRequest), "completed") as int
	print()
	print("save character: ", _player.stats.id)
	print("save level: ", _save.character.level)
	print()
	print("character: ", _save.character.id)
	print("character level: ", _player.stats.level)
	print()
	print("server level: ", server_level)
	print()
	if server_level < _player.stats.level:
		print("odesilani na server: ", _player.stats.level)
		yield(_http.set_progress(_player.stats.id, str(_player.stats.level), $HTTPRequest), "completed")
	elif server_level > _player.stats.level:
		$UI/PopUp.show()
		$UI/PopUp.dialog_text = "Chyba synchronizace postupu.\nDatabáze má vyšší postup ("+ str(server_level) +"),\nnež načtená hra ("+ str(_player.stats.level) +").\n\nPokud toto vidíš, oznam to dozoru."
		print("popup-varovani server")
	
func _pickup_hasicak() -> void:
	_inventory.inventory.add_item("extinguisher")
	GlobalData.hasicak = true
	get_node("YSort/Hasicak").hide()
	_save_game()