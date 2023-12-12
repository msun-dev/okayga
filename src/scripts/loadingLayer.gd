extends CanvasLayer

@onready var container = $preloadContainer

var frames: int = 0
var done_loading: bool = false

var eggxplotion = preload("res://src/assets/particles/particles.tscn")
var particles_to_preload = [
	eggxplotion
]

var egg = preload("res://src/scenes/egg.tscn")
var scenes_to_preload = [
	egg
]

func _ready() -> void:	
	set_visible(true)
	
	for particle in particles_to_preload:
		var instance = particle.instantiate()
		instance.set_position(get_viewport().get_visible_rect().size / 2)
		instance.set_color(Color(1,1,1,1))
		instance.set_one_shot(true)
		instance.set_emitting(true)
		add_child(instance)
	
	for scene in scenes_to_preload:
		var instance = scene.instantiate()
		instance.set_position(get_viewport().get_visible_rect().size / 2)
		instance.set_modulate(Color(1,1,1,1))
		add_child(instance)
	
	done_loading = true

func _physics_process(delta):
	if !done_loading: return
	frames += 1
	if frames >= 3:
		TransitionLayer.change_scene(TransitionLayer.menu_scene)
		set_physics_process(false)
