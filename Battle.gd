extends Node
export (PackedScene) var monster

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#handles by group?
#var monsters = []

func _ready():
	# add three monsters
	var m1 = monster.instance()
	m1.setType("monster")
	m1.coordinates = Vector2(630,240)
	add_child(m1)
	
	var m2 = monster.instance()
	m2.setType("monster")
	m2.coordinates = Vector2(750,315)
	add_child(m2)
	
	var m3 = monster.instance()
	m3.setType("monster")
	m3.coordinates = Vector2(650,390)
	add_child(m3)
	
func _on_btnExit_pressed():
        get_node("/root/global").goto_scene("res://world1.tscn")