extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "Fire Cloak"
	item_color = Color(1.0, 0.3, 0.0)
	super._ready()

func apply_effect(player) -> void:
	var existing = player.get_meta("fire_cloak_dmg") if player.has_meta("fire_cloak_dmg") else 0
	player.set_meta("fire_cloak_dmg", existing + 6)
