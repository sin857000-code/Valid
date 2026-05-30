extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "전쟁 망치"
	damage = 28
	range_radius = 32.0
	cooldown = 1.1
	item_color = Color(0.8, 0.6, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("stun_on_hit", true)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning", "scythe_mode"]:
		if player.has_meta(k):
			player.remove_meta(k)
