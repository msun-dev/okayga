extends CanvasLayer

@export var screen_setting: HBoxContainer

func _ready() -> void:
	if OS.get_name() == "Web":
		screen_setting.hide()

func _on_exit_pressed():
	TransitionLayer.change_scene(TransitionLayer.menu_scene)
