extends Marker2D

@onready var EggGenerator = get_node("/root/world/eggGenerator")
@onready var hands = $textures/hands

var MAX_DISTANCE = 230
var START_POSITION = 640
var freeze: bool = false

func _ready() -> void:
	SignalBus.connect("_disable", _on_disable)
	SignalBus.connect("_enable", _on_enable)
	SignalBus.connect("_eggsplotion", _on_eggsplotion)
	SignalBus.connect("_freeze", _on_freeze)
	SignalBus.connect("_unfreeze", _on_unfreeze)
	SignalBus.connect("_drop_egg", _on_drop_egg)

func _process(_delta) -> void:
	if !freeze: process_pos()

func disable() -> void:
	print('disable')
	set_process(false)
	$textures/headHappy.hide()
	$textures/egg.hide()
	$textures/hands.hide()

func enable() -> void:
	set_process(true)
	$textures/headHappy.show()
	$textures/headSad.hide()
	$textures/egg.show()
	$textures/hands.show()

func process_pos() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	global_position.x = clamp(mouse_pos.x, START_POSITION - MAX_DISTANCE, START_POSITION + MAX_DISTANCE)

func set_egg(size: int) -> void:
	$textures/egg.set_scale(EggConstants.get_egg_scale(size))
	$textures/egg.material.set("shader_parameter/color", EggConstants.get_shader_color(size))

func _on_drop_egg() -> void:
	if freeze: return
	if $cooldown.is_stopped():
		$textures/egg.hide()
		hands.play("drop")
		EggGenerator.create_future_egg(global_position)
		$cooldown.start()

func _on_cooldown_timeout() -> void:
	$textures/egg.show()
	hands.play("hold")

func _on_disable() -> void:
	disable()

func _on_enable() -> void:
	enable()

func _on_eggsplotion() -> void:
	set_process(false)
	$textures/headHappy.hide()
	$textures/headSad.show()
	$textures/egg.hide()
	$textures/hands.hide()

func _on_freeze() -> void:
	freeze = true

func _on_unfreeze() -> void:
	freeze = false
