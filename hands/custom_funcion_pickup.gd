@tool
extends XRToolsFunctionPickup

func _on_grip_pressed() -> void:
	#cochinada ahead, por favor no mover los nodos XR
	if Global.current_mask != null and \
		(get_parent().position - get_parent().get_parent().get_node("XRCamera3D").position).length() < 0.3:
		Global.current_mask.visible = true
		_pick_up_object(Global.current_mask)
		Global.current_mask = null
		Global.change_mask.emit("none")
	else:
		super._on_grip_pressed()
