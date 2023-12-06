extends CanvasLayer

@onready var container = $preloadContainer

var frames: int = 0

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
	set_physics_process(false)
	
	for particle in particles_to_preload:
		var instance = particle.instantiate()
		instance.set_position(get_viewport().get_visible_rect().size / 2)
		instance.set_color(Color(1,1,1,0))
		instance.set_one_shot(true)
		instance.set_emitting(true)
		container.add_child(instance)
	
	for scene in scenes_to_preload:
		var instance = scene.instantiate()
		instance.set_position(get_viewport().get_visible_rect().size / 2)
		instance.set_modulate(Color(1,1,1,0))
		container.add_child(instance)
	
	set_physics_process(true)

func _physics_process(delta):
	frames += 1
	if frames >= 3:
		TransitionLayer.change_scene(TransitionLayer.menu_scene)
