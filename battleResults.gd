extends Node

# class member variables go here, for example:
var loader
var wait_frames = 1
var time_max = 100 #msec
var mapResource = null
var mapScene = null
var mapLoaded = false
var waitingForMap = false

func _ready():
	mapResource = get_node("/root/global").get_map_resource()
	loader = ResourceLoader.load_interactive(mapResource)
	if (loader == null):
		show_error()
		return
	set_process(true)

func _process(delta):
	if (loader == null):
		set_process(false)
		return
	if (wait_frames > 0):
		wait_frames -= 1
		return
		
	var t = OS.get_ticks_msec()
	while (OS.get_ticks_msec() < t + time_max):
		var err = loader.poll()
		if (err == ERR_FILE_EOF):
			mapScene = loader.get_resource()
			if (waitingForMap): get_node("/root/global").goto_scene_loaded(mapScene)
			mapLoaded = true
			loader = null
			break
		elif (err == OK):
			#dipslay progress?
			pass
		else:
			show_error()
			loader = null
			break

func _on_okayButton_pressed():
	if (mapLoaded): get_node("/root/global").goto_scene_loaded(mapScene)
	else: waitingForMap = true
