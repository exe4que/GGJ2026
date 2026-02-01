extends Node

signal scene_loaded
signal scene_unloaded

func load_scene(scene_name: String):
	var target_scene = load(str("res://levels/", scene_name, ".tscn")).instantiate()
	get_tree().root.add_child(target_scene)
	scene_loaded.emit()

func unload_scene(scene_instance: Node):
	scene_instance.queue_free()
	scene_unloaded.emit()
