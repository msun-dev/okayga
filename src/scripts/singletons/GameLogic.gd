extends Node

@export var cosmetic: bool = false

var score: int = 0
var high: int = 0
var last: int = 0

func _ready() -> void:
	#SignalBus.connect("_update_high", _on_update_score)
	SignalBus.connect("_add_points", _on_add_points)
	SignalBus.connect("_trigger_game_over", _on_trigger_game_over)
	SignalBus.connect("_trigger_game_start", _on_trigger_game_start)
	self.high = Saver.get_data(Saver.PARAMETERS.HIGH_SCORE)
	#SignalBus.emit_signal("_load_score")
	_on_trigger_game_start()

func _process(delta):
	SignalBus.emit_signal("_update_ui_score",
	score,
	Saver.get_data(Saver.PARAMETERS.HIGH_SCORE),
	last)

func update_stats(stat: int, v: int = 0):
	# I don't really like this part. But that will do.
	if cosmetic:
		return
	
	match stat:
		0: # High score
			var sc: int = Saver.get_data(Saver.PARAMETERS.HIGH_SCORE)
			if sc < v:
				Saver.set_data(Saver.PARAMETERS.HIGH_SCORE, v)
		1: # Games played
			var gp: int = Saver.get_data(Saver.PARAMETERS.GAMES_PLAYED) 
			gp += 1;
			Saver.set_data(Saver.PARAMETERS.GAMES_PLAYED, gp)
		2: # Eggs stacked
			var es: int = Saver.get_data(Saver.PARAMETERS.EGGS_COMBINED) 
			es += 1;
			Saver.set_data(Saver.PARAMETERS.EGGS_COMBINED, es)
		3: # Max egg
			var be: int = Saver.get_data(Saver.PARAMETERS.BIGGEST_EGG) 
			if v > be:
				Saver.set_data(Saver.PARAMETERS.BIGGEST_EGG, v)

func game_start():
	update_stats(1)
	score = 0
	SignalBus.emit_signal("_load_score")
	SignalBus.emit_signal("_show_game_screen")
	update_ui_score()
	SignalBus.emit_signal("_enable")
	SignalBus.emit_signal("_unfreeze")

func game_over():
	SignalBus.emit_signal("_save_score", high)
	Saver.set_data(Saver.PARAMETERS.HIGH_SCORE, high)
	SignalBus.emit_signal("_eggsplotion")
	SignalBus.emit_signal("_disable")
	last = score
	await Signal(SignalBus, "_eggsploded")
	SignalBus.emit_signal("_show_game_over_screen")
	update_ui_score()

func show_settings() -> void:
	SignalBus.emit_signal("_disable")
	SignalBus.emit_signal("_show_settings_screen")

func show_game_over_screen() -> void:
	SignalBus.emit_signal("_disable")
	SignalBus.emit_signal("_show_game_screen")

func update_ui_score() -> void:
	SignalBus.emit_signal(
		"_update_ui_score", 
		score,
		Saver.get_data(Saver.PARAMETERS.HIGH_SCORE),
		last
	)
	
func _on_update_score(value) -> void:
	high = value
	update_ui_score()

func _on_add_points(size) -> void:
	update_stats(3, size)
	update_stats(2)
	if cosmetic: return
	var points = 2 + size ** 2
	score += points
	if score > high: 
		update_stats(0, score)
		high = score
	update_ui_score()

func _on_trigger_game_over() -> void:
	game_over()

func _on_trigger_game_start() -> void:
	game_start()
