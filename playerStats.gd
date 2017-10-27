extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var name = "Player"
var health = 10
var attack = 10
var speed = 10

var map = "map_sewer"
var position = Vector2(950,470)

var gold = 100
var items = {}

func _ready():
	items["monster_core"] = 10
	items["monster_hair"] = 2
	items["monster_claw"] = 5
	items["monster_claw_blue"] = 5
	items["monster_claw_red"] = 5
	items["monster_claw_gold"] = 5
	get_node("/root/global").set_current_map(map)

func get_gold():
	return gold

func get_items():
	return items

func get_last_position():
	return position

func set_position(pos):
	position = pos
