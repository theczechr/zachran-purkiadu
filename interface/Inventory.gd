extends Control

const ItemScene := preload("Item.tscn")	
export var hasicak_uses = 1
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

var hasicak_in_status = false
var ohen_in_status = false
func _unhandled_input(event):
	if Input.is_key_pressed(KEY_E) and hasicak_in_status:
			get_node("../../YSort/Hasicak/Sprite").hide()
			get_node("../../YSort/Hasicak/Kolize").disabled = true

			inventory.add_item("extinguisher")
	
	elif Input.is_key_pressed(KEY_E):
		if inventory.is_item("extinguisher"):
			inventory.remove_item("extinguisher")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		hasicak_in_status = true

func _on_Area2D_body_exited(body):
	hasicak_in_status = false
	
