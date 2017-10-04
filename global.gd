extends Node

var current_scene = null
var current_map = "world1"

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	#Adds the scene to the 'active scene', aka global
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func goto_scene_loaded(scene):
	current_scene.free()
	current_scene = scene.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)	

func get_map_resource():
	var mapResource = "res://%s.tscn" % current_map
	return mapResource