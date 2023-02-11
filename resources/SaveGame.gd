class_name SaveGame
extends Resource

const SAVE_GAME_BASE_PATH := "user://ZPU4" # Zachran Purkiadu Uloha X

export var character: Resource = Character.new()
export var inventory: Resource = Inventory.new()

static func save_exists() -> bool:
	return ResourceLoader.exists(get_save_path())

static func load_savegame() -> Resource:
	return ResourceLoader.load(get_save_path())

static func get_save_path() -> String:
	var extension := ".tres" if OS.is_debug_build() else ".res"
	return SAVE_GAME_BASE_PATH + extension
