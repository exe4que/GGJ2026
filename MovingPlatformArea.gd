extends Area3D

func _on_area_body_entered(body):
	if body.name == "XROrigin3D":
		body.reparent(self, true)

func _on_area_body_exited(body):
	if body.name == "XROrigin3D":
		body.reparent(get_tree().current_scene, true)
