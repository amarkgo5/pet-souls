extends Node

#const LinkedList = preload("res://Library/LinkedList.gd")

var portrait_resource = preload("res://turn_order_portrait.tscn")
var turn_list = []
var portrait_size
var turnID = 0

var ACTION_TIME = 1000

func _ready():
	portrait_size = get_node("Panel/turnOrderGrid").get_size().y

func add_to_turn_order(source):
	var new_turn = {}
	new_turn["id"] = (turnID + 1)
	new_turn["node"] = source
	new_turn["texture"] = source.get_node("Area2D/Sprite").get_texture()
	new_turn["speed"] = source.speed
	new_turn["delay"] = ACTION_TIME / new_turn["speed"]
	
	var insert_turn = false
	var turn_count = -1
	for turn in turn_list:
		turn_count += 1
		if (new_turn["delay"] < turn_list[turn_count]["delay"]):
			insert_turn = true
			break
	
	if (insert_turn):
		turn_list.insert(turn_count, new_turn)
	else:
		turn_list.append(new_turn)
	update_turn_grid()

func update_turn_grid():
	for node in get_node("Panel/turnOrderGrid").get_children():
		node.free()
	
	for turn in turn_list:
		var new_portrait  = portrait_resource.instance()
		new_portrait.get_node("TextureFrame").set_texture(turn["texture"])
		new_portrait.get_node("TextureFrame").set_size(Vector2(portrait_size,portrait_size))
		new_portrait.set_id(turn["id"])
		get_node("Panel/turnOrderGrid").add_child(new_portrait)

func get_next():
	return turn_list.front()["node"]

func take_turn(source):
	for turn in range(turn_list.size()):
		if (turn_list[turn]["node"] == source):
			var tempTurn = turn_list[turn]
			turn_list.remove(turn)
			tempTurn["delay"] = 1000 / tempTurn["speed"]
			turn_list.append(tempTurn)
	update_turn_grid()

func remove_from_turn_order(source):
	for turn in range(turn_list.size()-1, 0, -1):
		if (turn_list[turn]["node"] == source):
			turn_list.remove(turn)
	update_turn_grid()