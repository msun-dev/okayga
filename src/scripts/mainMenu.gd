extends CanvasLayer

@export var exit_button: Control

func _ready() -> void:
	if OS.get_name() == "Web":
		exit_button.hide()
		return
	Saver.load_data()
	if Saver.first_boot:
		match Saver.get_data(Saver.PARAMETERS.SCREEN_MODE):
			0:
				get_window().set_mode(Window.MODE_WINDOWED)
			1:
				get_window().set_mode(Window.MODE_FULLSCREEN)
			2:
				get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)

func _on_start_pressed():
	TransitionLayer.change_scene(TransitionLayer.game_scene)

func _on_settings_pressed():
	TransitionLayer.change_scene(TransitionLayer.settings_scene)

func _on_stats_pressed():
	TransitionLayer.change_scene(TransitionLayer.stats_scene)

func _on_exit_pressed():
	TransitionLayer.exit()
