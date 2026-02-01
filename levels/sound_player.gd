extends Node3D

@onready var area = $Area3D
@onready var audio = $AudioStreamPlayer

var played : bool


func _ready() -> void:
	area.area_entered.connect(_on_area_entered)


func _on_area_entered(other):
	if not played:
		audio.play()
		played = true
