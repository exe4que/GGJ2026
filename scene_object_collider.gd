extends CollisionObject3D

@export var scene_id : String

func _ready() -> void:
	Global.change_mask.connect(_on_mask_changed)


func _on_mask_changed(id):
	set_collision_layer_value(1, id == scene_id)
