extends Node

var current_scene = null
var current_map = "world1"

var resource_queue = [] 
var loading_resource = null
var loader = null
var loaded_resources = {}
var waiting_on_resource = null

export(int) var loader_wait_frames = 1
export(int) var loader_max_timePerLoad = 100

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)

func _process(delta):
	if (loading_resource == null):
		if (resource_queue.empty() == true):
			set_process(false)
			return
		else:
			loading_resource = resource_queue.front()
			resource_queue.pop_front()
			loader = ResourceLoader.load_interactive(loading_resource)
			loader_wait_frames = 1
	load_resource_interactive(loading_resource)

func load_resource_interactive(resource):
	if (loader == null):
		return
	if (loader_wait_frames > 0):
		loader_wait_frames -= 1
		return
		
	var t = OS.get_ticks_msec()
	while (OS.get_ticks_msec() < t + loader_max_timePerLoad):
		var err = loader.poll()
		if (err == ERR_FILE_EOF):
			loaded_resources[resource] = loader.get_resource()
			loader = null
			break
		elif (err == OK):
			#dipslay progress?
			pass
		else:
			show_error()
			loader = null
			break

func load_resource(resource):
	resource_queue.append(resource)
	set_process(true)

func is_resource_loaded(resource):
	if (loaded_resources.has(resource)): return true
	else: return false

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	#Adds the scene to the 'active scene', aka global
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func goto_scene_once_loaded(resource):
	if (is_resource_loaded(resource)): 
		goto_scene_with_loaded_resource(resource)
	else:
		#bump scene to top and load it as soon as it is ready
		waiting_on_resource = resource
		if (loading_resource != waiting_on_resource and resource_queue.front() != resource):
			resource_queue.remove(resource)
			resource_queue.push_front(resource)

func goto_scene_with_loaded_resource(resource):
	call_deferred("_deferred_goto_scene_with_loaded_resource", resource)

func _deferred_goto_scene_with_loaded_resource(resource):
	current_scene.free()
	current_scene = loaded_resources[resource].instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func goto_scene_loaded(scene):
	call_deferred("_deferred_goto_scene_loaded", scene)

func _deferred_goto_scene_loaded(scene):
	current_scene.free()
	current_scene = scene.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)	

func get_map_resource():
	var mapResource = "res://%s.tscn" % current_map
	return mapResource