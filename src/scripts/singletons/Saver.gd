extends Node

func _ready() -> void:
	SignalBus.connect("_save_score", _on_save_score)
	SignalBus.connect("_load_score", _on_load_score)

func load_score() -> void:
	if not FileAccess.file_exists("user://data.save"):
		return

	var save_game = FileAccess.open("user://data.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var data = json.get_data()
		for i in data.keys():
			if i == "high":
				SignalBus.emit_signal("_update_high", data[i])
			else:
				SignalBus.emit_signal("_update_high", 0)

func save_score(value) -> void:
	var file = FileAccess.open("user://data.save", FileAccess.WRITE)
	var json = {"high": value}
	var data = JSON.stringify(json)
	file.store_line(data)

func _on_load_score() -> void:
	load_score()

func _on_save_score(value) -> void:
	save_score(value)
