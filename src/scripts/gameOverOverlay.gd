extends CanvasLayer

@onready var animation = $animation

func _ready():
	SignalBus.connect("_update_ui_score", _on_update_ui_score)
	animation.play_backwards("dissolve")

func _on_start_pressed():
	SignalBus.emit_signal("_unfreeze")
	animation.play("dissolve")
	await animation.animation_finished
	SignalBus.emit_signal("_trigger_game_start")
	self.queue_free()

func _on_exit_pressed():
	#animation.play("dissolve")
	#await animation.animation_finished
	#SignalBus.emit_signal("_unfreeze")
	#SignalBus.emit_signal("_show_game_screen")
	TransitionLayer.change_scene(TransitionLayer.menu_scene)
	#self.queue_free()

func _on_update_ui_score(_score, high, last) -> void:
	$menu/score.set_text(str(last))
	$menu/high.set_text(str(high))
