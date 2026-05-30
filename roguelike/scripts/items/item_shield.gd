extends "res://scripts/items/item_base.gd"

var _shield_active: bool = false

func _ready() -> void:
	item_name = "보호막"
	item_color = Color(0.3, 0.7, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	if player.has_method("add_shield"):
		player.add_shield(1)
	else:
		# 보호막: 다음 피격 1회 무효화
		player.set_meta("shield", true)
		_show_shield_visual(player)

func _show_shield_visual(player: Node) -> void:
	var ring = ColorRect.new()
	ring.size = Vector2(22, 22)
	ring.position = Vector2(-11, -11)
	ring.color = Color(0.3, 0.7, 1.0, 0.35)
	player.add_child(ring)
	var tween = ring.create_tween().set_loops()
	tween.tween_property(ring, "modulate:a", 0.6, 0.5)
	tween.tween_property(ring, "modulate:a", 0.15, 0.5)
	player.set_meta("shield_visual", ring)
	player.set_meta("shield_tween", tween)
