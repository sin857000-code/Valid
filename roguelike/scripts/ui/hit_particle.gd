extends Node2D

# 히트 시 파티클 이펙트 (ColorRect 조각들이 튀어나감)
static func spawn(parent: Node, pos: Vector2, color: Color = Color.ORANGE) -> void:
	var count = 5
	for i in range(count):
		var p = ColorRect.new()
		p.size = Vector2(randi_range(2, 5), randi_range(2, 5))
		p.color = color
		p.position = pos
		parent.add_child(p)

		var angle = (float(i) / count) * TAU + randf() * 0.8
		var speed = randf_range(40, 100)
		var vel = Vector2(cos(angle), sin(angle)) * speed

		var tween = p.create_tween()
		tween.set_parallel(true)
		tween.tween_property(p, "position", pos + vel * 0.4, 0.35)
		tween.tween_property(p, "modulate:a", 0.0, 0.35)
		tween.tween_callback(p.queue_free).set_delay(0.35)
