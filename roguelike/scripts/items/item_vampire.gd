extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.6, 0.0, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	var steal = player.get_meta("lifesteal") if player.has_meta("lifesteal") else 0.0
	steal = min(steal + 0.25, 0.8)
	player.set_meta("lifesteal", steal)
	player.set_meta("vampire_aura", true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("흡혈귀 - 생명력 흡수 %.0f%%" % (steal * 100))
