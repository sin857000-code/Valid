extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "영혼 지팡이"
	damage = 15
	range_radius = 65.0
	cooldown = 0.4
	item_color = Color(0.7, 0.3, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("bouncing_shots", true)
	player.set_meta("chain_lightning", true)
	for k in ["attack_arc", "multishot", "freeze_on_hit", "scythe_mode", "stun_on_hit", "pierce_shot", "holy_light"]:
		if player.has_meta(k):
			player.remove_meta(k)
