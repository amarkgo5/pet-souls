extends Control

var item_count = 0
var item_id = null

func _ready():
	set_item_count(item_count)

func get_item_id():
	return item_id

func set_item_id(id):
	item_id = id

func set_item_texture(resource):
	var texture = ResourceLoader.load(resource)
	get_node("boxTexture/itemTexture").set_texture(texture)

func set_item_count(count):
	item_count = count
	var display
	if (item_count > 0):
		display = str(item_count)
	else:
		display = ""
	get_node("boxTexture/item_count").set_text(display)
