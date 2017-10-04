extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal monster_clicked

var name = ""
var attack = 5
var defence = 0
var health = 10
var coordinates = Vector2(0,0)
var image = null
var alive = true

var displayDamage = ""
var timeElapsed = 0
#func _init():
	#if (typeof(pos) == TYPE_VECTOR2): coordinates = pos

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_pos(coordinates)
	get_node("Area2D/Sprite").set_texture(image)
	#add_to_group("monsters")
	self.connect("monster_clicked", self.get_node("/root/Battle"), "monster_clicked")

func _process(delta):
	if (displayDamage != ""):
		if (timeElapsed == 0):
			get_node("Path2D/PathFollow2D/damageLbl").set_text(displayDamage)
			get_node("Path2D/PathFollow2D/damageLbl").set_opacity(1)
			get_node("Path2D/PathFollow2D").set_unit_offset(0)
			get_node("Path2D/PathFollow2D/damageLbl").show()
		timeElapsed += get_process_delta_time()
		
		var max_time = 2
		get_node("Path2D/PathFollow2D/damageLbl").set_opacity(1 -  (((timeElapsed / max_time) / 2) + 0.2))
		get_node("Path2D/PathFollow2D").set_unit_offset(timeElapsed / max_time)
		
		if (timeElapsed >= max_time):
			get_node("Path2D/PathFollow2D/damageLbl").hide()
			displayDamage = ""
			
		if (displayDamage == ""): set_process(false)

func setType(type):
	if (type == "" || type == "monster"): image = ResourceLoader.load("res://textures/monsters/monster.png")

func die():
	alive = false
	image = ResourceLoader.load("res://textures/monsters/death.png")
	get_node("Area2D/Sprite").set_texture(image)
	get_node("Area2D").set_pickable(false)

func takeDamage(damage):
	health -= int(damage)
	if (health <= 0): die()
	displayDamage = damage
	set_process(true)
	
func doStuff(viewport, event, shape_idx):
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.button_index == BUTTON_LEFT and event.pressed):
			emit_signal("monster_clicked", self)
	else:
		print("event")