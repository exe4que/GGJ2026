extends Node3D

@export var root_scene : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root_scene.connect("hide_scene", _on_hide_scene)
	root_scene.connect("show_scene", _on_show_scene)


func _on_hide_scene():
	$scene_collision.set_collision_layer_value(1, false)


func _on_show_scene():
	$scene_collision.set_collision_layer_value(1, true)
