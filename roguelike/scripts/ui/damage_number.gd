extends Node2D

# 피해량 표시 팝업 텍스트
static func spawn(parent: Node, pos: Vector2, amount: int, is_player: bool = false) -> void:
	var label = Label.new()
	label.text = str(amount)
	label.position = pos + Vector2(randi_range(-8, 8), -20)
	label.add_theme_font_size_override("font_size", 14)
	label.modulate = Color.RED if is_player else Color.YELLOW
	parent.add_child(label)

	var tween = label.create_tween()
	tween.set_parallel(true)
	tween.tween_property(label, "position:y", label.position.y - 30, 0.7)
	tween.tween_property(label, "modulate:a", 0.0, 0.7)
	tween.tween_callback(label.queue_free).set_delay(0.7)
