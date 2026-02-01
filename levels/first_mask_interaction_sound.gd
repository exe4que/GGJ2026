extends Node3D


func _ready() -> void:
	Global.change_mask.connect(_on_mask_changed)


func _on_mask_changed(mask):
	$FirstMaskSound.play()
	Global.change_mask.disconnect(_on_mask_changed)
