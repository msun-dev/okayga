extends CanvasLayer

@onready var animation = $animation

func _ready():
	animation.play_backwards("dissolve")

func _on_exit_settings_button_pressed():
	SignalBus.emit_signal("_unfreeze")
	animation.play("dissolve")
	await animation.animation_finished
	self.queue_free()

func _on_reset_button_pressed():
	animation.play("dissolve")
	await animation.animation_finished
	SignalBus.emit_signal("_unfreeze")
	SignalBus.emit_signal("_trigger_game_over")
	self.queue_free()
