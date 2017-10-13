extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var btnExplore
var map
var player

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	btnExplore = get_node("GUI/btnExplore")
	btnExplore.connect("pressed", self, "_on_btnExplore_pressed")
	get_node("/root/global").current_map = "map_sewer"
	
	var map_packed = load("res://Maps/map_sewer.tscn")
	map = map_packed.instance()
	add_child(map)
	get_node("/root/global").set_current_map("map_sewer")
	
	var player_packed = load("res://player.tscn")
	player = player_packed.instance()
	player.get_node("KinematicBody2D").set_pos(Vector2(950,470))
	var map_size = map.get_node("background").get_texture().get_size()
	player.get_node("KinematicBody2D/Camera2D").set_limit(MARGIN_RIGHT, map_size.x * 2)
	player.get_node("KinematicBody2D/Camera2D").set_limit(MARGIN_BOTTOM, map_size.y* 2)
	add_child(player)
	

func _on_btnExplore_pressed():
	# Change scene from map to battle
	get_node("/root/global").goto_scene("res://Battle.tscn")

func _on_btnItems_toggled(pressed):
	if (pressed):
		var inventory = preload("res://inventory.tscn")
		add_child(inventory.instance())
	else:
		get_node("inventory").free()
