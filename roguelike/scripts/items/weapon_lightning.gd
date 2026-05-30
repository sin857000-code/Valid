extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "번개 지팡이"
	damage = 18
	range_radius = 70.0
	cooldown = 0.7
	item_color = Color(1.0, 1.0, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("chain_lightning", true)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit"]:
		if player.has_meta(k):
			player.remove_meta(k)
