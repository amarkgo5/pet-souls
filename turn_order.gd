extends Node

#const LinkedList = preload("res://Library/LinkedList.gd")

var portrait_resource = preload("res://turn_order_portrait.tscn")
var turn_list = []
var portrait_size

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	portrait_size = get_node("Panel/turnOrderGrid").get_size().y
	pass

func add_to_turn_order(source):
	var new_turn = {}
	new_turn["node"] = source
	if (source.type == "player"): new_turn["texture"] = source.get_node("TextureFrame").get_texture()
	if (source.type == "monster"): new_turn["texture"] = source.get_node("Area2D/Sprite").get_texture()
	turn_list.append(new_turn)
	var new_portrait  = portrait_resource.instance()
	new_portrait.get_node("TextureFrame").set_texture(new_turn["texture"])
	new_portrait.get_node("TextureFrame").set_size(Vector2(portrait_size,portrait_size))
	get_node("Panel/turnOrderGrid").add_child(new_portrait)

func get_next():
	pass
