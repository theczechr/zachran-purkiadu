extends KinematicBody2D

var stats: Character setget set_stats

export(bool) var show_prompt setget _show_prompt_set

var velocity := Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	self.show_prompt = false
	randomize()
	animationTree.active = true
	
func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		self.show_prompt = false
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * 80, 500 * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, 500 * delta)
	
	velocity = move_and_slide(velocity)

func set_stats(new_stats: Character) -> void:
	stats = new_stats
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_P:
			emit_signal("input_event")
			Dialogic.set_variable(("hasicak_used"), "true")

func _show_prompt_set(new_value : bool):
	if new_value:
		$EKey.show()
		$EKeyAnimation.play("Animation")
	else:
		$EKey.hide()
		$EKeyAnimation.stop()
	
	show_prompt = new_value
	
func _show_prompt_get() -> bool:
	return show_prompt
