extends "res://scripts/items/item_base.gd"

const DURATION = 5.0

func _ready() -> void:
	item_name = "분노 물약"
	item_color = Color(1.0, 0.3, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.set_meta("rage_timer", DURATION)
	player.set_meta("rage_dmg_mult", 2.5)
	var ring = ColorRect.new()
	ring.size = Vector2(22, 22)
	ring.position = Vector2(-11, -11)
	ring.color = Color(1.0, 0.3, 0.0, 0.5)
	ring.name = "RageRing"
	player.add_child(ring)
	var pulse = ring.create_tween().set_loops()
	pulse.tween_property(ring, "modulate:a", 1.0, 0.15)
	pulse.tween_property(ring, "modulate:a", 0.3, 0.15)
	var expire = ring.create_tween()
	expire.tween_interval(DURATION)
	expire.tween_callback(ring.queue_free)
