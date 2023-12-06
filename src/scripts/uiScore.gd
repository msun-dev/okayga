extends Control

@onready var points_current = get_node_or_null("current/pointsContainer/score")
@onready var points_high = get_node_or_null("current/pointsContainer/high")

func _ready() -> void:
	SignalBus.connect("_update_ui_score", _on_update_ui_score)

func set_score(num: int = 0) -> void:
	points_current.set_text(str(num))

func set_high(num: int = 0) -> void:
	points_high.set_text(str(num))

func _on_update_ui_score(score, high, _last):
	set_score(score)
	set_high(high)
