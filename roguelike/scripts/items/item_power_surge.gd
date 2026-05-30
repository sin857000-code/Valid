extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 0.8, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Temporary big attack boost for 8 seconds
	var prev_dmg = player.attack_damage
	player.attack_damage = int(player.attack_damage * 2.0)
	player.set_meta("power_surge_timer", 8.0)
	player.set_meta("power_surge_base", prev_dmg)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("파워 서지! 공격력 2배 (8초)")
