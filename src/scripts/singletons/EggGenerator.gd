extends Node

@export var cosmetic: bool = false

@onready var egg_pool = get_node_or_null("../eggPool")
@onready var ui_future_egg = get_node_or_null("/root/world/ui/futureEgg")
@onready var okayga = get_node_or_null("/root/world/player/okayga")

@onready var egg = preload("res://src/scenes/egg.tscn")

var next_eggs: Array

func _ready() -> void:
	decide_egg()

func get_egg_rotation() -> int:
	return Rng.RNG.randi_range(0, 360)

func get_hands_rotation() -> int:
	return Rng.RNG.randi_range(-5, 5)
	
func get_current_egg() -> int:
	return next_eggs[0]

func get_future_egg() -> int:
	return next_eggs[1]

func decide_egg() -> void:
	while next_eggs.size() < 3: next_eggs.append(Rng.RNG.randi_range(0, EggConstants.MAX_EGG_SIZE))
	if !cosmetic:
		ui_future_egg.set_egg(get_future_egg())
		okayga.set_egg(get_current_egg())
	SignalBus.emit_signal("_update_future_eggs", next_eggs)

# Both methods below should be rewritten into more elegant way Donk
# But im too lazy to do that.
# For now!
func create_egg(size, pos) -> void:
	var egg_instance = egg.instantiate()
	egg_instance.set_egg(size)
	egg_instance.set_deferred("global_position", pos)
	egg_instance.set_deferred("rotation_degrees", get_egg_rotation())
	egg_pool.call_deferred("add_child", egg_instance)
	SignalBus.emit_signal("_add_points", size)

func create_future_egg(pos) -> void:
	var egg_instance = egg.instantiate()
	egg_instance.set_egg(next_eggs.pop_front())
	egg_instance.set_deferred("global_position", pos)
	egg_instance.set_deferred("rotation_degrees", get_hands_rotation())
	egg_pool.call_deferred("add_child", egg_instance)
	decide_egg()
