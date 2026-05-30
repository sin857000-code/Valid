extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 0.85, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Grants bonus score on each kill
	var bonus = player.get_meta("kill_score_bonus") if player.has_meta("kill_score_bonus") else 0
	bonus += 5
	player.set_meta("kill_score_bonus", bonus)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("황금 열풍! 처치당 +%d 점수" % bonus)
