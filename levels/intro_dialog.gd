extends Node3D

@export var firs_sequence : Array[AudioStreamPlayer]

#audio_list.append($D1)
#audio_list.append($D2)

func reproduce_list() -> void:
	for audio in firs_sequence:
		audio.play()
		await audio.finished

func _ready():
	SceneLoader.scene_unloaded.connect(on_scene_unloaded)
	print("holaaaaaa")
	
func on_scene_unloaded():
	reproduce_list()
	print("reproduzcooooo")
	
