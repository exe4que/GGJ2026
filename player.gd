extends Node3D


func _ready() -> void:
	Global.player = $PlayerBody
	Global.change_mask.emit("none")
