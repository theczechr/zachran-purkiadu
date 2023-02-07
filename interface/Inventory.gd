extends CanvasLayer

onready var items = "res://assets/icons/"
onready var loaded_items = {"Item1": "", "Item2": "Key"}

var stats: Inventory
 setget set_stats

func _ready():
	for item in get_tree().get_nodes_in_group("Items"):
		item.connect("pressed", self, "SelectItem", [item.get_parent().get_name()])

func SelectItem(item):
	pass
