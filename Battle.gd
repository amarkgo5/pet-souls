extends Node
export (PackedScene) var monster

# class member variables go here
enum BattleMode {START, WAIT, IDLE, SELECT_TARGET, END, RESULTS}
enum BattleAction {WAIT, SELECT, ATTACK, DEFEND}
var mode = BattleMode.START
var action = BattleAction.WAIT
var player = null
var targetNode = null

func _ready():
	player = get_node("player")
	# add three monsters
	addMonster("monster", 630, 240)
	#addMonster("monster", 750, 315)
	#addMonster("monster", 650, 390)
	set_process(true)

func _process(delta):
	#handles battle workflow
	if (mode == BattleMode.END):
		#run battle results
		#get_node("/root/global").goto_scene("res://world1.tscn")
		var battleResult = ResourceLoader.load("res://battleResults.tscn")
		var resultIns = battleResult.instance()
		mode = BattleMode.RESULTS
		add_child(resultIns)

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
	mode = BattleMode.IDLE
	action = BattleAction.WAIT
	# Take damage must go last as it can change the mode
	target.takeDamage(attacker.attack)
	
func checkEOB(sourceType, sourceNode):
	if (sourceType == "die"):
		if (sourceNode == player and !player.alive):
			mode = BattleMode.END
		#pet lookup as elif?
		else:
			var foundOne = false
			for mon in get_node("Monsters").get_children():
				if (mon.alive == true): 
					foundOne = true
					break
			if (!foundOne): mode = BattleMode.END

