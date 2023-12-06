extends Node

var music_value: float = 50
var sfx_value: float = 50

var music_db: float
var sfx_db: float

var range_db: float = 25

func _ready() -> void:
	pass

func set_value(value, type) -> void:
	if type == "music" : 
		music_value = value
		print("Set music to: ", value)
		SignalBus.emit_signal("_audio_settings_update")
	if type == "sfx" : 
		sfx_value = value
		print("Set sound to: ", value)
		SignalBus.emit_signal("_audio_settings_update")

func calculate_db(type) -> float:
	if type == "music" :
		if music_value == 0: return -100
		else: return (-range_db - 5 + music_value / 100 * range_db)
	if type == "sfx" :
		if sfx_value == 0: return -100
		else: return(-range_db - 5 + sfx_value / 100 * range_db)
	else: 
		print('error in audio calc')
		return 0.0

func get_db(type) -> float:
	return calculate_db(type)

func get_value(type: String) -> int:
	if type == "music": return music_value
	if type == "sfx": return sfx_value
	else: return 50
