extends Node3D

@export var blue_scene : Node3D
@export var red_scene : Node3D

var blue_scene_collision_nodes;
var red_scene_collision_nodes;

func _ready() -> void:
	blue_scene_collision_nodes = get_tree().get_nodes_in_group("blue_collision");
	red_scene_collision_nodes = get_tree().get_nodes_in_group("red_collision");


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_to_blue"):
		red_scene.visible = false
		blue_scene.visible = true
		for node in blue_scene_collision_nodes:
			node.set_collision_layer_value(1, true)
		for node in red_scene_collision_nodes:
			node.set_collision_layer_value(1, false)
	if Input.is_action_just_pressed("change_to_red"):
		for node in blue_scene_collision_nodes:
			node.set_collision_layer_value(1, false)
		for node in red_scene_collision_nodes:
			node.set_collision_layer_value(1, true)
		red_scene.visible = true
		blue_scene.visible = false
