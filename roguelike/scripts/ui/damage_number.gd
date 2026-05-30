extends Node2D

# 피해량 표시 팝업 텍스트
static func spawn(parent: Node, pos: Vector2, amount: int, is_player: bool = false, is_crit: bool = false) -> void:
	var label = Label.new()
	label.text = ("CRIT! " if is_crit else "") + str(amount)
	label.position = pos + Vector2(randi_range(-8, 8), -20)
	var font_size = 20 if is_crit else 14
	label.add_theme_font_size_override("font_size", font_size)
	if is_crit:
		label.modulate = Color(1.0, 0.6, 0.0)
	else:
		label.modulate = Color.RED if is_player else Color.YELLOW
	parent.add_child(label)

	var tween = label.create_tween()
	tween.set_parallel(true)
	var rise = 50 if is_crit else 30
	tween.tween_property(label, "position:y", label.position.y - rise, 0.7)
	tween.tween_property(label, "modulate:a", 0.0, 0.7)
	tween.tween_callback(label.queue_free).set_delay(0.7)
