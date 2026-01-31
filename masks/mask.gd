@tool
extends XRToolsPickable

@export var id : String

func _ready() -> void:
	dropped.connect(_on_mask_dropped)


func _on_mask_dropped(mask):
	if Global.current_mask == null and (position - Global.player.position).length() < 0.5:
		Global.change_mask.emit(id)
		Global.current_mask = self
		visible = false
