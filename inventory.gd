extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var item_box = preload("res://item_box.tscn")
var inventory_size = 13

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	load_inventory()
	load_gold()
	var btnItems = self.get_node("/root/world1/ParallaxBackground/btnItems")
	var parentPos = btnItems.get_begin()
	var parentSize = btnItems.get_size()
	var selfSize = get_size()
	set_pos(Vector2(parentPos.x + parentSize.x - selfSize.x, parentPos.y - selfSize.y))

func load_inventory():
	var grid = get_node("GridContainer")
	for i in range(inventory_size):
		var next_slot = item_box.instance()
		grid.add_child(next_slot)

func load_gold():
	var gold = get_node("/root/playerStats").get_gold()
	get_node("footer/goldLbl").set_text(str(gold))

func add_item():
	pass