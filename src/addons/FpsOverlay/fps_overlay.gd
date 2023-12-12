extends CanvasLayer

@onready var counter = $FpsContainer/Counter

func _ready():
	self.set_visible(false)

func _process(delta):
	counter.set_text(str(Engine.get_frames_per_second()))

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F1:
			self.set_visible(!is_visible())
			self.set_process(is_visible())
