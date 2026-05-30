extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "유리 대포"
	damage = 60
	range_radius = 45.0
	cooldown = 2.0
	item_color = Color(0.4, 0.8, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning"]:
		if player.has_meta(k):
			player.remove_meta(k)
