extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var name = "Player"
var health = 10
var attack = 10
var speed = 10

var map = "world1"
var position = Vector2()

var gold = 100
var items = {}

func _ready():
	items["monster_core"] = 10
	items["monster_hair"] = 2

func get_gold():
	return gold

func get_items():
	return items
