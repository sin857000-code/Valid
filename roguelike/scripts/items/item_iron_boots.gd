extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.5, 0.5, 0.7)
	super._ready()

func _apply_effect(player: Node) -> void:
	var dr = player.get_meta("damage_reduction") if player.has_meta("damage_reduction") else 0.0
	dr = min(dr + 0.15, 0.5)
	player.set_meta("damage_reduction", dr)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("철갑화 - 피해 감소 %.0f%%" % (dr * 100))
