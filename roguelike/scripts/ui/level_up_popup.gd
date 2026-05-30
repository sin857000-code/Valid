extends CanvasLayer

@onready var label: Label = $Panel/Label

func show_level_up(new_level: int) -> void:
	label.text = "LEVEL UP!  Lv.%d" % new_level
	visible = true
	var panel = $Panel
	panel.modulate.a = 0.0
	panel.scale = Vector2(0.6, 0.6)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(panel, "modulate:a", 1.0, 0.2)
	tween.tween_property(panel, "scale", Vector2(1.1, 1.1), 0.2)
	tween.chain().tween_property(panel, "scale", Vector2(1.0, 1.0), 0.1)
	tween.chain().tween_interval(1.5)
	tween.chain().tween_property(panel, "modulate:a", 0.0, 0.4)
	tween.chain().tween_callback(func(): visible = false; panel.scale = Vector2.ONE)
	_burst_particles()

func _burst_particles() -> void:
	for i in range(12):
		var p = ColorRect.new()
		p.size = Vector2(4, 4)
		p.color = Color(randf_range(0.8, 1.0), randf_range(0.7, 1.0), 0.2)
		p.position = Vector2(randf_range(20, 180), randf_range(20, 60))
		add_child(p)
		var angle = randf() * TAU
		var speed = randf_range(50, 120)
		var tween = p.create_tween().set_parallel(true)
		tween.tween_property(p, "position", p.position + Vector2(cos(angle), sin(angle)) * speed * 0.5, 0.6)
		tween.tween_property(p, "modulate:a", 0.0, 0.6)
		tween.tween_callback(p.queue_free).set_delay(0.6)
