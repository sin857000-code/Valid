extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "마법봉"
	damage = 20
	range_radius = 100.0
	cooldown = 0.8
	item_color = Color(0.8, 0.3, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("bouncing_shots", true)
