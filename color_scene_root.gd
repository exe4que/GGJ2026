extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tree().get_nodes_in_group("blue_collision"):
		print(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
