extends Node

var RNG = RandomNumberGenerator.new()

func _ready() -> void:
	RNG.randomize()
