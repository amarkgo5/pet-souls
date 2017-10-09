extends Node

export var floating_time = 2.0
var displayDamage = ""
var timeElapsed = 0

func _ready():
	set_process(true)

func _process(delta):
	if (timeElapsed == 0):
		get_node("Path2D/PathFollow2D/Label").set_text(displayDamage)
		get_node("Path2D/PathFollow2D/Label").set_opacity(1)
		get_node("Path2D/PathFollow2D").set_unit_offset(0)
		get_node("Path2D/PathFollow2D/Label").show()
	timeElapsed += get_process_delta_time()
	
	get_node("Path2D/PathFollow2D/Label").set_opacity(1 -  (((timeElapsed / floating_time) / 2) + 0.2))
	get_node("Path2D/PathFollow2D").set_unit_offset(timeElapsed / floating_time)
	
	if (timeElapsed >= floating_time):
		get_node("Path2D/PathFollow2D/Label").hide()
		displayDamage = ""
		
	if (displayDamage == ""): self.free()
	
func setDamage(damage):
	displayDamage = String(damage)

func positionToObject(object):
	var objPos = object.get_begin()
	var objSize = object.get_node("Area2D/Sprite").get_texture().get_size()
	var middleX = (objSize.x / 4 + objPos.x)
	var middleY = (objSize.y / 4 + objPos.y)
	get_node("Path2D").set_pos(Vector2(middleX, middleY))
	