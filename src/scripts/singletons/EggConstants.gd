extends Node

#first - smallest, last - biggest
var EGG_COLORS = [
	"#ffe5d1",
	"#6cb0b0",
	"#fea47d",
	"#8b69a5",
	"#c27b7f",
	"#fdeead",
	"#79b386",
	"#ffa7a4",
	"#6475a1",
	"#c75061",
	"#000000"
]
var SCALE_MIN: float = 0.05
var SCALE_STEP: float = 0.02
var MAX_EGG_SIZE: int = 2

func get_shader_color(size: int) -> Color:
	return Color.from_string(EggConstants.EGG_COLORS[size], Color.WHITE)

func get_egg_scale(size: int) -> Vector2:
	var scale = SCALE_MIN + SCALE_STEP * size
	return Vector2(scale, scale)
