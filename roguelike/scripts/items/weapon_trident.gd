extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "삼지창"
	damage = 14
	range_radius = 65.0
	cooldown = 0.7
	item_color = Color(0.2, 0.8, 0.9)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("multishot", true)
	player.set_meta("bouncing_shots", true)
	for k in ["attack_arc", "freeze_on_hit", "chain_lightning", "scythe_mode", "stun_on_hit", "pierce_shot"]:
		if player.has_meta(k):
			player.remove_meta(k)
