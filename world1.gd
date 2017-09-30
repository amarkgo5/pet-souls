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
	# Change scene from map to battle
	get_node("/root/global").goto_scene("res://Battle.tscn")