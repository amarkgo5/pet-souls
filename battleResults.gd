extends Node

# class member variables go here, for example:

func _ready():
	get_node("/root/global").load_resource(get_node("/root/global").get_map_resource())

func _on_okayButton_pressed():
	get_node("/root/global").return_to_map()
