extends CanvasLayer

@export var games_played: Label
@export var high_score: Label
@export var eggs_stacked: Label
@export var max_egg: Label

func _ready() -> void:
	self.games_played.set_text(str(Saver.get_data(Saver.PARAMETERS.GAMES_PLAYED)))
	self.high_score.set_text(str(Saver.get_data(Saver.PARAMETERS.HIGH_SCORE)))
	self.eggs_stacked.set_text(str(Saver.get_data(Saver.PARAMETERS.EGGS_COMBINED)))
	self.max_egg.set_text(str(Saver.get_data(Saver.PARAMETERS.BIGGEST_EGG)))

func _on_exit_pressed():
	TransitionLayer.change_scene(TransitionLayer.menu_scene)
