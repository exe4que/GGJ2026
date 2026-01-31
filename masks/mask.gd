@tool
extends XRToolsPickable

@export var id : String

func _ready() -> void:
	picked_up.connect(_on_mask_pickedup)


func _on_mask_pickedup(_mask):
	print("picked up")
	Global.change_mask.emit(id)
