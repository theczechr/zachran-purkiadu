class_name SaveGame
extends Resource

const SAVE_GAME_BASE_PATH := "user://ZPU4" # Zachran Purkiadu Uloha X

# Use this to detect old player saves and update their data.
export var version := 1

# We directly reference the characters stats and inventory in the save game resource.
# When saving this resource, they'll get saved alongside it.
export var character: Resource = Character.new()
export var inventory: Resource = Inventory.new()

func write_savegame() -> void:
	ResourceSaver.save(get_save_path(), self)

static func save_exists() -> bool:
	return ResourceLoader.exists(get_save_path())

static func load_savegame() -> Resource:
	var save_path := get_save_path()
	if ResourceLoader.has_cached(save_path):
		# Once the resource caching bug is fixed, you will only need this line of code to load the save game.
		return ResourceLoader.load(save_path, "", true)

	# We first load the save game resource's content as a byte array and store it.
	var file := File.new()
	if file.open(save_path, File.READ) != OK:
		printerr("Couldn't read file " + save_path)
		return null

	var data := file.get_buffer(file.get_len())
	file.close()

	# Then, we generate a random file path that's not in Godot's cache.
	var tmp_file_path := make_random_path()
	while ResourceLoader.has_cached(tmp_file_path):
		tmp_file_path = make_random_path()

	# We write a copy of the save game to that temporary file path.
	if file.open(tmp_file_path, File.WRITE) != OK:
		printerr("Couldn't write file " + tmp_file_path)
		return null

	file.store_buffer(data)
	file.close()

	# We load the temporary file as a resource.
	var save = ResourceLoader.load(tmp_file_path, "", true)
	save.take_over_path(save_path)

	var directory := Directory.new()
	directory.remove(tmp_file_path)
	return save


static func make_random_path() -> String:
	return "user://temp_file_" + str(randi()) + ".tres"

static func get_save_path() -> String:
	var extension := ".tres" if OS.is_debug_build() else ".res"
	return SAVE_GAME_BASE_PATH + extension
