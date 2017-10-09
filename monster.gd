extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal monster_clicked
signal die 

var type = "monster"
var name = ""
var health = 0
var attack = 0
var speed = 0
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

func load_from_dict(monster_dict):
	setType(monster_dict["resource"])
	health = int(monster_dict["health"])
	attack = int(monster_dict["attack"])
	speed = int(monster_dict["speed"])

func setType(type):
	var resString = "res://textures/monsters/%s.png" % type
	if (!File.new().file_exists(resString)): resString = "res://textures/monsters/monster.png"
	image = ResourceLoader.load(resString)

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