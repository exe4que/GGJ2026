extends Node3D

@export var scene_id : String

func _ready() -> void:
	Global.change_mask.connect(_on_mask_changed)


func _on_mask_changed(id):
	visible = id == scene_id
