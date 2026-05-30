extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "흡혈 반지"
	item_color = Color(0.8, 0.1, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	var current = player.get_meta("lifesteal") if player.has_meta("lifesteal") else 0.0
	player.set_meta("lifesteal", min(current + 0.15, 0.6))  # 15% lifesteal per stack, max 60%
