extends RigidBody2D

@onready var EggGenerator = get_node("../../eggGenerator")

@export var AGE: float = Time.get_ticks_msec()
@export var SIZE: int
@export var marked_for_death: bool

func _ready() -> void:
	SignalBus.connect("_eggsplotion", _on_eggsplotion)
	set_egg(SIZE)

func _physics_process(delta):
	check_for_egg()

func check_for_egg() -> void:
	if is_queued_for_deletion(): return
	if marked_for_death: return
	if is_sleeping(): return #eggs cant sleep so its a bit useless

	var bodies = $hitbox.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("egg"):
			var body_size = body.get_size()
			if  body_size == SIZE and body_size < 10:
				if body.get_age() < get_age():
					var new_pos = self.get_global_position()
					EggGenerator.create_egg(SIZE + 1, new_pos)
					body.destroy()
					destroy()
					break


func _on_body_entered(body):
	if body.is_in_group("egg"):
		var body_size = body.get_size()
		if  body_size == SIZE and body_size < 10:
			if body.get_age() < get_age():
				$crackEffect.play_sound()
		else: $hitEffect.play_sound()
	else: 
		var floor_hit_effect = get_node_or_null("floorHitEffect")
		if floor_hit_effect: $floorHitEffect.play_sound()

func set_egg(egg_size: int) -> void:
	SIZE = egg_size
	var size_scale = EggConstants.get_egg_scale(SIZE)
	set_size(size_scale)
	set_color(SIZE)
	set_mass(SIZE + 1)
	#$shape.set_disabled(false)

func set_size(size: Vector2) -> void:
	$shape.set_scale(size)
	$hitbox/shape.set_scale(size * 1.03)
	$texture.set_scale(size)

func set_color(size: int) -> void:
	var color = EggConstants.get_shader_color(size)
	$texture.material.set("shader_parameter/color", color)
	$particles.set_color(color)
	if size > 9:
		var rainbow = preload("res://src/assets/shaders/eggRainbow.tres")
		$texture.set_material(rainbow)

func get_age() -> float:
	return AGE

func get_size() -> float:
	return SIZE

func destroy() -> void:
	marked_for_death = true
	$crackEffect.play_sound()
	$texture.hide()
	$shape.set_deferred("disabled", true)
	set_deferred("freeze", true)
	$particles.set_emitting(true)
	$timer.start()

func _on_eggsplotion() -> void:
	if !marked_for_death:
		marked_for_death = true
		$eggsplotionTimer.start(Rng.RNG.randf_range(0.3, 1.5))

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_eggsplotion_timer_timeout() -> void:
	$crackEffect.play_sound()
	destroy()
