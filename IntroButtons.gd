extends Node2D

func canva_fade_out_to_scene(node, scene) -> void:
	node.visible = true
	get_tree().change_scene_to_file(scene)
	node.visible = false
	#tween.tween_property(node, "Modulate:A", 0, 255)

func _on_play_button_pressed() -> void:
	canva_fade_out_to_scene($CanvasLayer/CoverTransition, 'res://main_level.tscn')
	print('Play Button Pressed!')
	
func _on_home_button_pressed() -> void:
	print('Home Button Pressed!')
	#Home Function
	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	print('Exit Button Pressed!')
	#Quit Function:
	pass # Replace with function body.
