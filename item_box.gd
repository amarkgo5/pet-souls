extends Control

var item_count = 0
var item_id = null
var name = ""
var description = ""

func _ready():
	set_item_count(item_count)
	set_process_input(true)

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

func _input(event):
	if event.type == 2:
		var mouse_event_pos = event.pos
		var myPos = get_global_pos()
		if myPos.x < mouse_event_pos.x and mouse_event_pos.x < (myPos.x+50):
			if myPos.y < mouse_event_pos.y and mouse_event_pos.y < (myPos.y+50):
				get_node("descPanel").set_hidden(false)
				get_node("descPanel").set_global_pos(mouse_event_pos)
			else:
				get_node("descPanel").set_hidden(true)
		else:
			get_node("descPanel").set_hidden(true)
