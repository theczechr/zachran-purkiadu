extends Label


var line_active = 0

var bg_default = load("res://assets/bg_default.tres")
var bg_green = load("res://assets/bg_green.tres")
var bg_yellow = load("res://assets/bg_yellow.tres")
var bg_gray = load("res://assets/bg_gray.tres")

var array_status = [bg_default, bg_gray, bg_green, bg_yellow]

func _ready():
	change_status(0)
	
func change_status(status):
	$AnimationPlayer.play("flip")
	yield(get_tree().create_timer(0.3), "timeout")
	$AnimationPlayer.play("flip_back")
	theme = array_status[status]


func pop_anim():
	$AnimationPlayer.play("pop")
