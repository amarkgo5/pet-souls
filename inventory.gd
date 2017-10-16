extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var item_dict = {}
var item_box = preload("res://item_box.tscn")
var inventory_size = 13

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	load_item_dict()
	load_inventory()
	load_gold()
	add_items()
	var btnItems = self.get_node("/root/map_view/GUI/btnItems")
	var parentPos = btnItems.get_begin()
	var parentSize = btnItems.get_size()
	var selfSize = get_size()
	set_pos(Vector2(parentSize.x - selfSize.x, - selfSize.y))

func load_item_dict():
	var file = File.new()
	if (!file.file_exists("res://items.json")):
		print("Items.json file doesn't exist")
		return
	file.open("res://items.json", file.READ)
	var text = file.get_as_text()
	item_dict.parse_json(text)
	file.close()
	
func load_inventory():
	var grid = get_node("GridContainer")
	for i in range(inventory_size):
		var next_slot = item_box.instance()
		grid.add_child(next_slot)

func load_gold():
	var gold = get_node("/root/playerStats").get_gold()
	get_node("footer/goldLbl").set_text(str(gold))

func add_items():
	var items = get_node("/root/playerStats").get_items()
	for item in items:
		var resource = "res://textures/items/%s.png" % item_dict[item]["resource"]
		for c in range(get_node("GridContainer").get_child_count()):
			var item_box = get_node("GridContainer").get_child(c)
			if (item_box.get_item_id() == null):
				item_box.set_item_id(item)
				item_box.set_item_texture(resource)
				item_box.set_item_count(items[item])
				break
