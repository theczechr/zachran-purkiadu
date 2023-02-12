extends Area2D

export (int) var NEXT_PROGRESS : int = 1

signal checkpoint_requested

var status = false;

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("checkpoint_requested", NEXT_PROGRESS)
	status = true;

func _on_Checkpoint_body_exited(body):
	status = false;
