extends Node2D

@onready var EggGenerator = get_node("../eggGenerator")

@export var enabled: bool = true
@export var spawn_time: float = 1

func _ready():
	SignalBus.connect("_disable", _on_disable)
	SignalBus.connect("_enable", _on_enable)

func _on_timer_timeout():
	if enabled:
		EggGenerator.create_future_egg(get_global_position())
		$timer.start(spawn_time)

func _on_disable() -> void:
	$timer.stop
	enabled = false

func _on_enable()  -> void:
	$timer.start(spawn_time)
	enabled = true
	
