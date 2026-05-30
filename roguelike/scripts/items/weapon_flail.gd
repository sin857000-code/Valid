extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "도리깨"
	damage = 20
	range_radius = 50.0
	cooldown = 0.5
	item_color = Color(0.7, 0.3, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	# Arc attack with knockback boost
	player.set_meta("attack_arc", true)
	player.set_meta("knockback_boost", true)
	for k in ["multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning", "scythe_mode", "stun_on_hit", "pierce_shot"]:
		if player.has_meta(k):
			player.remove_meta(k)
