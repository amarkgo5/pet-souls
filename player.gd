extends Node

export var SPEED = 150

var vel = Vector2()
var body

func _ready():
	body = get_node("KinematicBody2D")
	set_fixed_process(true)

func _fixed_process(delta):
	vel = Vector2(0,0)
	if (Input.is_action_pressed("ui_up")):
		vel += Vector2(0, -SPEED)
	if (Input.is_action_pressed("ui_down")):
		vel += Vector2(0, SPEED)
	if (Input.is_action_pressed("ui_left")):
		vel += Vector2(-SPEED, 0)
	if (Input.is_action_pressed("ui_right")):
		vel += Vector2(SPEED, 0)
	
	var motion = vel * delta
	body.move(motion)
	if (body.is_colliding()):
		var n = body.get_collision_normal()
		motion = n.slide(motion)
		#vel = n.slide(vel)
		body.move(motion)

