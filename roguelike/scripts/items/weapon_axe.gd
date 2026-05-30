extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "도끼"
	damage = 22
	range_radius = 40.0
	cooldown = 0.8
	item_color = Color(0.7, 0.5, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("attack_arc", true)
	for k in ["multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning"]:
		if player.has_meta(k):
			player.remove_meta(k)
