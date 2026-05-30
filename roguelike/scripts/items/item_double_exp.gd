extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.9, 1.0, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	var mult = player.get_meta("exp_mult") if player.has_meta("exp_mult") else 1.0
	mult = min(mult + 0.5, 3.0)
	player.set_meta("exp_mult", mult)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("경험치 %.0fx 배율!" % mult)
