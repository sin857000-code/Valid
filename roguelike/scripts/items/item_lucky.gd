extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 0.9, 0.1)
	super._ready()

func _apply_effect(player: Node) -> void:
	var luck = player.get_meta("crit_bonus") if player.has_meta("crit_bonus") else 0.0
	luck = min(luck + 0.1, 0.6)
	player.set_meta("crit_bonus", luck)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("행운 - 치명타율 +10%% (%.0f%%)" % ((0.12 + luck) * 100))
