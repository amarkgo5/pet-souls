extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var btnExplore

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	btnExplore = get_node("btnExplore")
	btnExplore.connect("pressed", self, "_on_btnExplore_pressed")
	pass

func _on_btnExplore_pressed():
	# create instance of battle
	#var scene = load("res://Battle.tscn")
	#var node = scene.instance()
	#add_child(node)
	get_tree().change_scene("res://Battle.tscn")