extends Control

var item_count = 1

func _ready():
	set_item_count(item_count)

func set_item_texture(texture):
	get_node("boxTexture/itemTexture").set_texture(texture)

func set_item_count(count):
	get_node("boxTexture/item_count").set_text(str(count))
