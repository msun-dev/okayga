extends HSlider

@export_enum("music", "sfx") var type: String

func _ready():
	set_value(AudioSettings.get_value(type))

func _on_value_changed(volume):
	AudioSettings.set_value(volume, type)
