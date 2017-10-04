extends Node

# class member variables go here, for example:
var mapResource = null
var mapScene = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	mapResource = get_node("/root/global").get_map_resource()
	mapScene = load(mapResource)

func _on_okayButton_pressed():
	get_node("/root/global").goto_scene_loaded(mapScene)
