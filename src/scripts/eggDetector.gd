extends Area2D

@onready var timer_text = $timerText

func _ready() -> void:
	SignalBus.connect("_disable", _on_disable)
	SignalBus.connect("_enable", _on_enable)

func _process(delta) -> void:
	var timeLeft = $timer.get_time_left()
	if timeLeft < 3 and timeLeft > 0:
		timer_text.set_text(str("%0.2f" % $timer.get_time_left()))
	else:
		timer_text.set_text("")
	
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("egg"): 
			if $timer.is_stopped(): 
				$timer.start()
	if !bodies: 
		$timer.stop()

func _on_disable() -> void:
	timer_text.hide()
	$timer.stop()
	self.set_process(false)

func _on_enable() -> void:
	timer_text.show()
	self.set_process(true)

func _on_timer_timeout() -> void:
	print("detector trigger")
	SignalBus.emit_signal("_trigger_game_over")
