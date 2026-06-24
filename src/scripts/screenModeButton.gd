extends MenuButton


enum SCREEN_MODES {WINDOWED = 0, FULLSCREEN = 1, EXCLUSIVE_FS = 2}
const sm: Array[StringName] = ["windowed", "fullscreen", "exclusive fs"]

func _ready() -> void:
	for i in SCREEN_MODES.size():
		self.get_popup().add_item(sm[i])

	self.get_popup().id_pressed.connect(_on_id_pressed)
	update_text()

func update_text() -> void:
	self.set_text(sm[Saver.get_data(Saver.PARAMETERS.SCREEN_MODE)])

func update_sm() -> void:
	match Saver.get_data(Saver.PARAMETERS.SCREEN_MODE):
		0:
			get_window().set_mode(Window.MODE_WINDOWED)
		1:
			get_window().set_mode(Window.MODE_FULLSCREEN)
		2:
			get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)

func _on_id_pressed(v: int) -> void:
	Saver.set_data(Saver.PARAMETERS.SCREEN_MODE, v)
	update_text()
	update_sm()
