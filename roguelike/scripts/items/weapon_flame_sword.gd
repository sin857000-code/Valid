extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Flame Sword"
	damage = 20
	range_radius = 55.0
	cooldown = 0.8
	item_color = Color(1.0, 0.4, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("attack_arc", true)
	for k in ["chain_lightning", "multishot", "bouncing_shots", "freeze_on_hit"]:
		if player.has_meta(k):
			player.remove_meta(k)
