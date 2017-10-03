extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _toggled(pressed):
	if self.is_pressed():
		self.text = "Target"
	else:
		self.text = "Attack"

func deselect():
	self.set_pressed(false)
	self.text = "Attack"