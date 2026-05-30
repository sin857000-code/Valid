extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "암흑검"
	damage = 30
	range_radius = 36.0
	cooldown = 0.45
	item_color = Color(0.2, 0.0, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	# Dark blade drains nearby enemies (like vampire)
	player.set_meta("vampire_aura", true)
	for k in ["attack_arc", "multishot", "bouncing_shots", "freeze_on_hit", "chain_lightning", "scythe_mode", "stun_on_hit", "pierce_shot", "holy_light"]:
		if player.has_meta(k):
			player.remove_meta(k)
