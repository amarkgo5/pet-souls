extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var name = ""
var attack = 5
var defence = 0
var health = 10
var coordinates = Vector2(0,0)
var image = null
var alive = true

#func _init():
	#if (typeof(pos) == TYPE_VECTOR2): coordinates = pos
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_pos(coordinates)
	get_node("monsterTexture").set_texture(image)
	add_to_group("monsters")

func setType(type):
	if (type == "" || type == "monster"): image = ResourceLoader.load("res://textures/monsters/monster.png")

func die():
	alive = false
	image = ResourceLoader.load("res://textures/monsters/death.png")

func takeDamage(damage):
	health -= damage
	if (health <= 0): die()