extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal monster_clicked
signal die 

var name = ""
var attack = 5
var defence = 0
var health = 10
var coordinates = Vector2(0,0)
var image = null
var alive = true

var floatingDamage = preload("res://floatingDamage.tscn")
#func _init():
	#if (typeof(pos) == TYPE_VECTOR2): coordinates = pos

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_pos(coordinates)
	get_node("Area2D/Sprite").set_texture(image)
	#add_to_group("monsters")
	self.connect("monster_clicked", self.get_node("/root/Battle"), "monster_clicked")
	self.connect("die", self.get_node("/root/Battle"), "checkEOB")

func setType(type):
	if (type == "" || type == "monster"): image = ResourceLoader.load("res://textures/monsters/monster.png")

func die():
	alive = false
	image = ResourceLoader.load("res://textures/monsters/death.png")
	get_node("Area2D/Sprite").set_texture(image)
	get_node("Area2D").set_pickable(false)
	emit_signal("die", "die", self)

func takeDamage(damage):
	health -= int(damage)
	if (health <= 0): die()
	var damageNode = floatingDamage.instance()
	damageNode.positionToObject(self)
	damageNode.setDamage(damage)
	add_child(damageNode)

func doStuff(viewport, event, shape_idx):
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.button_index == BUTTON_LEFT and event.pressed):
			emit_signal("monster_clicked", self)
	#else:
	#	print("event")