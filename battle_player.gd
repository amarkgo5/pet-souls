extends "playerStats.gd"

# class member variables go here, for example:
var floatingDamage = preload("res://floatingDamage.tscn")

var type = "player"
var alive = true
var movementSpeed = 20
var inAttackAnimation = false
var timeElapsed = 0

var actionMode = false
var lastActionMode = null

func _ready():
	set_process(true)

func _process(delta):
	timeElapsed += get_process_delta_time()
	if (timeElapsed >= 2):
		updateAttackAnimation()
		timeElapsed = 0
		if (inAttackAnimation): inAttackAnimation = false
		else: inAttackAnimation = true
	
	if (actionMode != lastActionMode):
		lastActionMode = actionMode
		#make actions avail/unavail

func updateAttackAnimation():
	var image = get_node("Area2D/Sprite")
	var curPos = image.get_pos()
	curPos.x += movementSpeed
	image.set_pos(curPos)
	movementSpeed *= -1

func set_action(action):
	actionMode = action

func takeDamage(damage):
	health -= int(damage)
	if (health <= 0): die()
	var damageNode = floatingDamage.instance()
	damageNode.positionToObject(self)
	damageNode.setDamage(damage)
	add_child(damageNode)