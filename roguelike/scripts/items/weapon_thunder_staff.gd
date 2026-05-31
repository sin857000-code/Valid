extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Thunder Staff"
	damage = 22
	range_radius = 180.0
	cooldown = 1.2
	item_color = Color(0.8, 0.9, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("chain_lightning", true)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit"]:
		if player.has_meta(k):
			player.remove_meta(k)
