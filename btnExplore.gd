extends Button

# class member variables go here, for example:
#signal pressed
var on = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _draw():
	var r = Rect2(Vector2(), get_size())
	if (on):
		draw_rect(r, Color(1,0,0))
	else:
		draw_rect(r, Color(0,1,0))
		
func _input_event(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed):
		on = true 
		emit_signal("pressed")
		update()