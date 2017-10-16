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
	get_node("/root/global").set_current_map("map_sewer")
	
	var map
	var map_resource = get_node("/root/global").get_map_resource()
	if (!get_node("/root/global").is_resource_loaded(map_resource)):
		map = load(map_resource).instance()
	else:
		var map_packaged = get_node("/root/global").get_loaded_resource(map_resource)
		map = map_packaged.instance()
	add_child(map)
	#get_node("/root/global").set_current_map("map_sewer")
	
	player = load("res://player.tscn").instance()
	player.get_node("KinematicBody2D").set_pos(get_node("/root/playerStats").get_last_position())
	var map_size = map.get_node("background").get_texture().get_size()
	player.get_node("KinematicBody2D/Camera2D").set_limit(MARGIN_RIGHT, map_size.x * 2)
	player.get_node("KinematicBody2D/Camera2D").set_limit(MARGIN_BOTTOM, map_size.y* 2)
	add_child(player)
	

func _on_btnExplore_pressed():
	get_node("/root/playerStats").set_position(player.get_node("KinematicBody2D").get_pos())
	get_node("/root/global").goto_scene("res://Battle.tscn")

func _on_btnItems_toggled(pressed):
	if (pressed):
		var inventory = preload("res://inventory.tscn")
		get_node("GUI/btnItems").add_child(inventory.instance())
	else:
		get_node("GUI/btnItems/inventory").free()
