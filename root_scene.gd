extends Node3D

signal show_scene
signal hide_scene


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_to_blue"):
		visible = true
		show_scene.emit()
	if Input.is_action_just_pressed("change_to_red"):
		visible = false
		hide_scene.emit()
