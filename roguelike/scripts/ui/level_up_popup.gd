extends CanvasLayer

@onready var label: Label = $Panel/Label

func show_level_up(new_level: int) -> void:
	label.text = "LEVEL UP!  Lv.%d" % new_level
	visible = true
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(func(): visible = false)
