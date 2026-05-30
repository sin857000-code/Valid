extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "성검"
	damage = 35
	range_radius = 38.0
	cooldown = 0.6
	item_color = Color(1.0, 1.0, 0.5)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("holy_light", true)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning", "scythe_mode", "stun_on_hit", "pierce_shot"]:
		if player.has_meta(k):
			player.remove_meta(k)
