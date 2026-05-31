extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Frost Bow"
	damage = 18
	range_radius = 200.0
	cooldown = 1.1
	item_color = Color(0.5, 0.8, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("freeze_on_hit", true)
	for k in ["chain_lightning", "attack_arc", "multishot", "bouncing_shots"]:
		if player.has_meta(k):
			player.remove_meta(k)
