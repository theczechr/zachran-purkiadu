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
				inventory.remove_item("extinguisher", 1)
		elif event.scancode == KEY_2:
			pass
		elif event.scancode == KEY_3:
			pass
				
func _add_random_item() -> void:
	var item_unique_id: String = ItemDatabase.ITEMS.keys()[randi() % ItemDatabase.ITEMS.keys().size()]
	inventory.add_item(item_unique_id, 1)

func _remove_random_item() -> void:
	if inventory.items:
		inventory.remove_item(inventory.items.keys()[randi() % inventory.items.keys().size()])

var state = false
func _unhandled_input(event):
	if (Input.is_key_pressed(KEY_E) and state):
			get_node("../../YSort/Hasicak/Sprite").hide()
			get_node("../../YSort/Hasicak/Kolize").disabled = true
			
			inventory.add_item("extinguisher")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		state = true

func _on_Area2D_body_exited(body):
	state = false
