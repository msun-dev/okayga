extends Area2D

var mouse_inside_area = false

func _ready() -> void:
	SignalBus.connect("_freeze", _on_freeze)
	SignalBus.connect("_unfreeze", _on_unfreeze)
	SignalBus.connect("_disable", _on_disable)
	SignalBus.connect("_enable", _on_enable)

func _process(delta):
	if Input.is_action_just_pressed("drop") and mouse_inside_area:
		SignalBus.emit_signal("_drop_egg")

func _on_mouse_entered():
	mouse_inside_area = true

func _on_mouse_exited():
	mouse_inside_area = false

func _on_freeze() -> void:
	set_process(false)

func _on_unfreeze() -> void:
	set_process(true)

func _on_disable() -> void:
	set_process(false)

func _on_enable() -> void:
	set_process(true)
