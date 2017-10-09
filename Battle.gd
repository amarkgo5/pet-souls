extends Node
export (PackedScene) var monster

# class member variables go here
enum BattleMode {START, WAIT, IDLE, SELECT_TARGET, END, RESULTS}
enum BattleAction {WAIT, SELECT, ATTACK, DEFEND}
var mode = BattleMode.START
var action = BattleAction.WAIT
var player = null
var targetNode = null
var monster_dict = {}

# Built in Methods

func _ready():
	player = get_node("player")
	#add player to turn order
	get_node("turn_order").add_to_turn_order(player)
	
	load_monster_dict()
	# add three monsters
	var mCount = randi()%100+1
	addMonster(randi()%3+1, 630, 240)
	if (mCount > 25): addMonster(randi()%3+1, 650, 390)
	if (mCount > 75): addMonster(randi()%3+1, 750, 315)
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

func _on_btnExit_pressed():
	get_node("/root/global").goto_scene("res://world1.tscn")

func _on_btnAttack_toggled(pressed):
	if (pressed == false): 
		action = BattleAction.WAIT
		mode = BattleMode.IDLE
		return
	
	action = BattleAction.ATTACK
	mode = BattleMode.SELECT_TARGET

# Emitter Methods

func monster_clicked(monsterNode):
	if (mode == BattleMode.SELECT_TARGET):
		attackTarget(player, monsterNode)
		get_node("btnAttack").deselect()

# Local implementation

func load_monster_dict():
	var file = File.new()
	if (!file.file_exists("res://monsters.json")):
		print("Monster.json file doesn't exist")
		return
	file.open("res://monsters.json", file.READ)
	var text = file.get_as_text()
	monster_dict.parse_json(text)
	file.close()

func addMonster(mIndex, x, y):
	var monstersNode = get_node("Monsters")
	var m = monster.instance()
	m.load_from_dict(monster_dict[String(mIndex)])
	m.coordinates = Vector2(x,y)
	monstersNode.add_child(m)
	get_node("turn_order").add_to_turn_order(m)

func attackTarget(attacker, target):
	mode = BattleMode.IDLE
	action = BattleAction.WAIT
	# Take damage must go last as it can change the mode
	target.takeDamage(attacker.attack)
	get_node("turn_order").take_turn(attacker)
	
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

