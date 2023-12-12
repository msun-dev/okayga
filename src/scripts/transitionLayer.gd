extends CanvasLayer

signal _done_loading

var menu_scene = "res://src/scenes/menus/mainMenu.tscn"
var settings_scene = "res://src/scenes/menus/settingsMenu.tscn"
var game_scene = "res://src/scenes/world.tscn"


func change_scene(target: String) -> void:
	$animation.play('dissolve')
	await $animation.animation_finished
	get_tree().change_scene_to_file(target)
	$animation.play_backwards('dissolve')

func exit() -> void:
	$animation.play('dissolve')
	await $animation.animation_finished
	get_tree().quit()
