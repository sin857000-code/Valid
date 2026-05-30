extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "부메랑"
	damage = 14
	range_radius = 55.0
	cooldown = 0.5
	item_color = Color(0.5, 1.0, 0.5)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	# Boomerang hits in a wide arc (all enemies within range, not just attack cone)
	player.set_meta("attack_arc", true)
