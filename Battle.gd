extends Node
export (PackedScene) var monster

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#handles by group?
#var monsters = []

func _ready():
	# add three monsters
	addMonster("monster", 630, 240)
	addMonster("monster", 750, 315)
	addMonster("monster", 650, 390)

func addMonster(type, x, y):
	var monstersNode = get_node("Monsters")
	var m = monster.instance()
	m.setType(type)
	m.coordinates = Vector2(x,y)
	monstersNode.add_child(m)

func _on_btnExit_pressed():
	get_node("/root/global").goto_scene("res://world1.tscn")

func _on_btnAttack_toggled(pressed):
	if (pressed == false): return
	var target = ""