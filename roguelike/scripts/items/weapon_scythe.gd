extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "낫"
	damage = 16
	range_radius = 55.0
	cooldown = 0.6
	item_color = Color(0.6, 0.1, 0.9)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	# Wide 360 arc (uses attack_arc but with extended range)
	player.set_meta("attack_arc", true)
	player.set_meta("scythe_mode", true)
	for k in ["multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning"]:
		if player.has_meta(k):
			player.remove_meta(k)
