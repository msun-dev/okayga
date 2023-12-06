extends CanvasLayer

func _on_start_pressed():
	TransitionLayer.change_scene(TransitionLayer.game_scene)

func _on_settings_pressed():
	TransitionLayer.change_scene(TransitionLayer.settings_scene)

func _on_exit_pressed():
	pass # Replace with function body.
