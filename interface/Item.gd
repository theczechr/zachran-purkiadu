class_name Item
extends Panel

var item_unique_id := ""

onready var texture_rect := $TextureRect

func display_item(unique_id: String, amount: int) -> void:
	item_unique_id = unique_id

	var data := ItemDatabase.get_item_data(unique_id)
	texture_rect.texture = data.icon
