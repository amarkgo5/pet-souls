extends "playerStats.gd"

# class member variables go here, for example:
var type = "player"
var alive = true
var movementSpeed = 20
var inAttackAnimation = false
var timeElapsed = 0

func _ready():
	set_process(true)

func _process(delta):
	timeElapsed += get_process_delta_time()
	if (timeElapsed >= 2):
		updateAttackAnimation()
		timeElapsed = 0
		if (inAttackAnimation): inAttackAnimation = false
		else: inAttackAnimation = true

func updateAttackAnimation():
	var image = get_node("TextureFrame")
	var curPos = image.get_pos()
	curPos.x += movementSpeed
	image.set_pos(curPos)
	movementSpeed *= -1