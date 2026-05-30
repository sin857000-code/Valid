extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "Frost Aura"
	item_color = Color(0.5, 0.8, 1.0)
	super._ready()

func apply_effect(player) -> void:
	player.set_meta("frost_aura", true)
