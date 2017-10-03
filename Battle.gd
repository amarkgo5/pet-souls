extends Node
export (PackedScene) var monster

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum BattleAction {WAIT, SELECT, ATTACK, DEFEND}
enum BattleMode {WAIT, IDLE, SELECT_TARGET}
var action = BattleAction.WAIT
var mode = BattleMode.IDLE
var player = null
var targetNode = null

func _ready():
	player = get_node("player")
	# add three monsters
	addMonster("monster", 630, 240)
	addMonster("monster", 750, 315)
	addMonster("monster", 650, 390)
	set_process(true)

func addMonster(type, x, y):
	var monstersNode = get_node("Monsters")
	var m = monster.instance()
	m.setType(type)
	m.coordinates = Vector2(x,y)
	monstersNode.add_child(m)

func _on_btnExit_pressed():
	get_node("/root/global").goto_scene("res://world1.tscn")

func _on_btnAttack_toggled(pressed):
	if (pressed == false): 
		action = BattleAction.WAIT
		mode = BattleMode.IDLE
		return
	
	action = BattleAction.ATTACK
	mode = BattleMode.SELECT_TARGET
	
func monster_clicked(monsterNode):
	if (mode == BattleMode.SELECT_TARGET):
		attackTarget(player, monsterNode)
		get_node("btnAttack").deselect()
		
func attackTarget(attacker, target):
	target.takeDamage(attacker.attack)
	