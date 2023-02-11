extends Area2D

signal save_or_load_requested

var status = false;

func _ready():
	print("ENTERED")

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		print("Sending signal")
		emit_signal("save_or_load_requested")
	status = true;

func _on_Checkpoint_body_exited(body):
	status = false;
