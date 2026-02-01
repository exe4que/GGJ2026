extends CanvasLayer

@export var next_scene: String
@export var duration: float

@onready var Fade: ColorRect = $Fade
@onready var PlayButton: TextureButton = $Background/TittleContainer/VBoxContainer/ButtonContainer/PlayButton
@onready var ExitButton: TextureButton = $PanelContainer/ExitButton


func _ready():
	PlayButton.pressed.connect(_on_play_button_pressed)
	ExitButton.pressed.connect(_on_exit_button_pressed)
	SceneLoader.scene_loaded.connect(_on_scene_loaded)
	print("Ready!")
	pass
	
func _on_play_button_pressed() -> void:
	print("Play Button Pressed")
	transition_in(next_scene)
	PlayButton.disabled = true
	pass
	
func transition_in(target_scene: String):
	# Fade to Black
	var tween = create_tween()
	tween.tween_property(Fade, "color", Color(0, 0, 0, 1), duration / 2)
	tween.tween_callback(func(): SceneLoader.load_scene(target_scene))
	print("Tween done")
	
func _on_scene_loaded():
		# Fade to transparent
	var tween = create_tween()
	tween.tween_property(Fade, "color", Color(0, 0, 0, 0), duration / 2)
	var intro_scene = get_parent()
	var background = $Background
	background.visible = false
	tween.tween_callback(func(): SceneLoader.unload_scene(intro_scene))
	print("Transition done")
	pass
	
func _on_exit_button_pressed():
	print("Exit Button Pressed")
	get_tree().quit()
		
	
