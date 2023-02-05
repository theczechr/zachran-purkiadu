extends KinematicBody2D

const DRAG_FACTOR := 0.15
const DIRECTION_TO_FRAME := {
	Vector2.DOWN: 0,
	Vector2.DOWN + Vector2.RIGHT: 1,
	Vector2.RIGHT: 2,
	Vector2.UP + Vector2.RIGHT: 3,
	Vector2.UP: 4,
}

var stats: Character setget set_stats

var velocity := Vector2.ZERO

onready var sprite := $Sprite
onready var camera := $Camera2D

func _ready() -> void:
	set_physics_process(false)


func set_stats(new_stats: Character) -> void:
	stats = new_stats
	set_physics_process(stats != null)


func toggle_camera_offset(is_offset: bool) -> void:
	camera.position.x = 424.0 if is_offset else 0.0
