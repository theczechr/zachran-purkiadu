extends Control

const ItemScene := preload("Item.tscn")

var inventory: Inventory = null setget set_inventory

onready var _item_grid := $HBoxContainer/ItemGrid as GridContainer

func _ready() -> void:
	# INFO: Funguje jenom kdyz spustite tuto scenu, jinak ne
	if get_parent() == get_tree().root:
		var test_inventory := Inventory.new()
		test_inventory.add_item("extinguisher")
		set_inventory(test_inventory)

func set_inventory(new_inventory: Inventory) -> void:
	if inventory != new_inventory:
		new_inventory.connect("changed", self, "_update_items_display")

	inventory = new_inventory
	_update_items_display()

func _update_items_display() -> void:
	for node in _item_grid.get_children():
		node.queue_free()
	
	for item_unique_id in inventory.items:
		var item: Item = ItemScene.instance()
		_item_grid.add_child(item)
		item.display_item(item_unique_id, inventory.get_amount(item_unique_id))

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_1:
			if inventory.is_item("extinguisher"):
				inventory.remove_item("extinguisher")
		elif event.scancode == KEY_2:
			pass
		elif event.scancode == KEY_3:
			pass
