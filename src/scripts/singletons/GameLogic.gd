extends Node

@export var cosmetic: bool = false

var score: int = 0
var high: int = 0
var last: int = 0

func _ready() -> void:
	SignalBus.connect("_update_high", _on_update_score)
	SignalBus.connect("_add_points", _on_add_points)
	SignalBus.connect("_trigger_game_over", _on_trigger_game_over)
	SignalBus.connect("_trigger_game_start", _on_trigger_game_start)
	SignalBus.emit_signal("_load_score")

func _process(delta):
	SignalBus.emit_signal("_update_ui_score", score, high, last)

func game_start():
	score = 0
	SignalBus.emit_signal("_load_score")
	SignalBus.emit_signal("_show_game_screen")
	SignalBus.emit_signal("_update_ui_score", score, high, last)
	SignalBus.emit_signal("_enable")

func game_over():
	SignalBus.emit_signal("_save_score", high)
	SignalBus.emit_signal("_eggsplotion")
	SignalBus.emit_signal("_disable")
	last = score
	await Signal(SignalBus, "_eggsploded")
	SignalBus.emit_signal("_show_game_over_screen")

func show_settings() -> void:
	SignalBus.emit_signal("_disable")
	SignalBus.emit_signal("_show_settings_screen")

func show_game_over_screen() -> void:
	SignalBus.emit_signal("_disable")
	SignalBus.emit_signal("_show_game_screen")

func _on_update_score(value) -> void:
	high = value
	SignalBus.emit_signal("_update_ui_score", score, high, last)

func _on_add_points(size) -> void:
	if cosmetic: return
	var points = 2 + size ** 2
	score += points
	if score > high: high = score
	SignalBus.emit_signal("_update_ui_score", score, high, last)

func _on_trigger_game_over() -> void:
	game_over()

func _on_trigger_game_start() -> void:
	game_start()
