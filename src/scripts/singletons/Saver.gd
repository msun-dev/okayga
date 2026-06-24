extends Node

var first_boot = true

enum PARAMETERS {
	VOLUME_MUSIC, VOLUME_SFX, SCREEN_MODE,
	HIGH_SCORE, GAMES_PLAYED, EGGS_COMBINED, BIGGEST_EGG
}
# General
var current_version := "0.3.1"
# Settings
var volume_music := 50.
var volume_sfx   := 50.
var screen_mode  := 0
# Stats
var high_score    := 0
var games_played  := 0
var eggs_combined := 0
var biggest_egg   := 0

func _ready() -> void:
	SignalBus._audio_settings_update.connect(_on_audio_setting_update)

func load_data() -> void:
	if not FileAccess.file_exists("user://data.save"):
		return

	var save_game = FileAccess.open("user://data.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			continue
		var data = json.get_data()
		update_savefile(data)
		for i in data.keys():
			# Settings
			if i == "volume_music":
				pass
			if i == "volume_sfx":
				self.volume_sfx = data[i]
			if i == "screen_mode":
				self.screen_mode = data[i]
			# Data
			if i == "high_score":
				self.high_score = data[i]
				#SignalBus.emit_signal("_update_high", data[i])
			if i == "games_played":
				self.games_played = data[i]
			if i == "eggs_combined":
				self.eggs_combined = data[i]
			if i == "biggest_egg":
				self.biggest_egg = data[i]
		SignalBus._load_data.emit()

# save_score
func save_data() -> void:
	var file = FileAccess.open("user://data.save", FileAccess.WRITE)
	var json = {
		"version" : current_version,
		# Settings
		"screen_mode" : screen_mode,
		"volume_sfx"  : volume_sfx,
		"volume_music": volume_music,
		# Data
		"high_score"    : high_score,
		"games_played"  : games_played,
		"eggs_combined" : eggs_combined,
		"biggest_egg"   : biggest_egg,
	}

	var data = JSON.stringify(json)
	file.store_line(data)

func update_savefile(d: Variant) -> void:
	for i in d.keys():
		if i == "high": # From 0.3 to 0.3.1
			self.high_score = d[i]
			save_data()
		if i == "version": # From 0.3.1 to ...
			if d[i] == "0.3.1":
				pass

func get_data(p: PARAMETERS) -> Variant:
	match p:
		PARAMETERS.VOLUME_MUSIC:
			return volume_music
		PARAMETERS.VOLUME_SFX:
			return volume_sfx
		PARAMETERS.SCREEN_MODE:
			return screen_mode
		
		PARAMETERS.HIGH_SCORE:
			return high_score
		PARAMETERS.GAMES_PLAYED:
			return games_played
		PARAMETERS.EGGS_COMBINED:
			return eggs_combined
		PARAMETERS.BIGGEST_EGG:
			return biggest_egg
	return null

func set_data(p: PARAMETERS, v: Variant) -> void:
	match p:
		PARAMETERS.VOLUME_MUSIC:
			volume_music = v
		PARAMETERS.VOLUME_SFX:
			volume_sfx = v
		PARAMETERS.SCREEN_MODE:
			screen_mode  = v
		
		PARAMETERS.HIGH_SCORE:
			high_score = v
		PARAMETERS.GAMES_PLAYED:
			games_played = v
		PARAMETERS.EGGS_COMBINED:
			eggs_combined = v
		PARAMETERS.BIGGEST_EGG:
			biggest_egg = v
	
	save_data()

func _on_load_score() -> void:
	load_data()

func _on_save_score(value) -> void:
	high_score = value
	save_data()

func _on_audio_setting_update() -> void:
	self.volume_sfx = AudioSettings.sfx_value
	save_data()
