extends Control

var SIZE_DEFAULT = Vector2(70,70)

func set_egg(SIZE: int) -> void:
	$timer.start()
	await $timer.timeout
	$texture.show()
	$texture.set_custom_minimum_size(SIZE_DEFAULT + Vector2(15, 15) * SIZE)
	$texture.material.set("shader_parameter/color", EggConstants.get_shader_color(SIZE))
