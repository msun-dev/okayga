extends Node2D

var egg_count: int
var allowed_to_eggsplode: bool = false

func _ready() -> void:
	SignalBus.connect("_eggsplotion", _on_eggsplotion)

func _process(delta) -> void:
	egg_count = get_child_count(true)
	if allowed_to_eggsplode:
		SignalBus.emit_signal("_eggsplotion")
		if egg_count == 0:
			SignalBus.emit_signal("_eggsploded")
			allowed_to_eggsplode = false

func get_egg_count() -> int:
	return egg_count

func _on_eggsplotion() -> void:
	allowed_to_eggsplode = true
