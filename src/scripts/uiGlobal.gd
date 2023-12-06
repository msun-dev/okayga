extends Control

@onready var ui_score = $score

var settings_scene = preload("res://src/scenes/menus/settingsOverlay.tscn")

func _ready() -> void:
	SignalBus.connect("_show_game_screen", _on_show_game_screen)
	SignalBus.connect("_show_settings", _on_show_settings)
	SignalBus.connect("_show_game_over_screen", _on_show_game_over_screen)
	SignalBus.connect("_update_ui_score", _on_update_ui_score)

func instance_overlay(scene_node) -> void:
	var scene = scene_node.instantiate()
	call_deferred("add_child", scene)

# Instance menu instead of showing/hiding it
func _on_show_game_screen() -> void: # Del
	SignalBus.emit_signal("_unfreeze")

func _on_show_settings() -> void:
	SignalBus.emit_signal("_freeze")
	instance_overlay(settings_scene)

func _on_show_game_over_screen() -> void:
	TransitionLayer.change_scene(TransitionLayer.menu_scene)

func _on_play_button_pressed():
	SignalBus.emit_signal("_trigger_game_start")

func _on_play_again_button_pressed():
	SignalBus.emit_signal("_trigger_game_start")

func _on_settings_button_pressed():
	_on_show_settings()

func _on_exit_settings_button_pressed():
	_on_show_game_screen()

func _on_update_ui_score(score, high, _last):
	if has_node(str(ui_score)): 
		ui_score.set_high(high)
		ui_score.set_score(score)

func _on_reset_button_pressed():
	_on_show_game_screen()
	SignalBus.emit_signal("_unfreeze")
	SignalBus.emit_signal("_trigger_game_start")

