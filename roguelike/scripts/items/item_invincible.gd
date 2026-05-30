extends "res://scripts/items/item_base.gd"

const DURATION = 3.0

func _ready() -> void:
	item_name = "무적 물약"
	item_color = Color(1.0, 1.0, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.set_meta("invincible_timer", DURATION)
	var ring = ColorRect.new()
	ring.size = Vector2(20, 20)
	ring.position = Vector2(-10, -10)
	ring.color = Color(1.0, 1.0, 0.2, 0.5)
	player.add_child(ring)
	var tween = ring.create_tween()
	tween.tween_interval(DURATION)
	tween.tween_callback(ring.queue_free)
	var pulse = ring.create_tween().set_loops()
	pulse.tween_property(ring, "modulate:a", 0.9, 0.2)
	pulse.tween_property(ring, "modulate:a", 0.2, 0.2)
