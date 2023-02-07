extends CanvasLayer

onready var items = "res://assets/icons/"
onready var loaded_items = {"Item1": SaveGame, "Item2": "Key"}

var inventory: Inventory = null setget set_inventory

func _ready() -> void:
	# If running the scene with F6, we create an inventory for testing purposes.
	if get_parent() == get_tree().root:
		var test_inventory := Inventory.new()
		test_inventory.add_item("healing_gem", 3)
		test_inventory.add_item("sword", 2)
		set_inventory(test_inventory)

	_add_item_button.connect("pressed", self, "_add_random_item")
	_remove_item_button.connect("pressed", self, "_remove_random_item")


func set_inventory(new_inventory: Inventory) -> void:
	if inventory != new_inventory:
		new_inventory.connect("changed", self, "_update_items_display")

	inventory = new_inventory
	_update_items_display()


func _update_items_display() -> void:
	for node in _item_grid.get_children():
		node.queue_free()
	
	for item_unique_id in inventory.items:
		var ui_item: UIItem = UIItemScene.instance()
		_item_grid.add_child(ui_item)
		ui_item.display_item(item_unique_id, inventory.get_amount(item_unique_id))
		ui_item.connect("tooltip_requested", self, "_on_tooltip_requested", [ui_item])
