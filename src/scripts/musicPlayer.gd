extends AudioStreamPlayer

@export_enum("music", "sfx") var type: String
@export var is_repeating: bool = false
@export var pitch_range: float = 0
@export var cooldown: float = 0.0
@export var oneshot: bool = false

func _ready() -> void:
	SignalBus.connect("_audio_settings_update", _on_volume_update)
	set_volume_db(AudioSettings.get_db(type))

func play_sound() -> void:
	set_pitch_scale(1 + Rng.RNG.randf_range(-pitch_range, pitch_range))
	if !$timer.is_stopped():
		return
	play()
	if cooldown != 0.0: $timer.start()

func _on_volume_update() -> void:
	set_volume_db(AudioSettings.get_db(type))

func _on_finished() -> void:
	if is_repeating: play()
	if oneshot: self.queue_free()

func _on_timer_timeout():
	pass # Replace with function body.
