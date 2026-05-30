extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "냉기 지팡이"
	damage = 12
	range_radius = 60.0
	cooldown = 0.5
	item_color = Color(0.5, 0.9, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("freeze_on_hit", true)
	# Clear conflicting weapon metas
	for k in ["attack_arc", "multishot", "bouncing_shots"]:
		if player.has_meta(k):
			player.remove_meta(k)
