extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "창"
	damage = 20
	range_radius = 80.0
	cooldown = 0.55
	item_color = Color(0.6, 0.8, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("pierce_shot", true)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning", "scythe_mode", "stun_on_hit"]:
		if player.has_meta(k):
			player.remove_meta(k)
