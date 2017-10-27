extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var progressBar
var max_progress = 20
var current_progress = 0
var progress_ticking = false

var time_elapsed = 0

func _ready():
	progressBar = get_node("PanelContainer/Container/ProgressBar")
	progressBar.set_value(0)

func _process(delta):
	time_elapsed += get_process_delta_time()
	if (progress_ticking):
		var progress = time_elapsed / max_progress * 100
		progressBar.set_value(floor(progress))
		
		#start shrinking energy sprite
		var cur_scale = get_node("PanelContainer/Container/TextureFrame/Sprite").get_scale()
		if (cur_scale.x > 0.01 and cur_scale.y > 0.01): cur_scale -= Vector2(0.001,0.001)
		get_node("PanelContainer/Container/TextureFrame/Sprite").set_scale(cur_scale)
		
		if progress >= 100:
			progress_ticking = false
			set_process(false)

func start_progress():
	progress_ticking = true
	set_process(true)
