extends Node3D

@export var speed : float;


func _process(delta: float) -> void:
	rotate(Vector3.UP, delta * speed)
