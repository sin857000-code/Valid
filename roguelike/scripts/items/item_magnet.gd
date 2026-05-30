extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.8, 0.3, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	var range_val = player.get_meta("magnet_range") if player.has_meta("magnet_range") else 0.0
	range_val = min(range_val + 60.0, 200.0)
	player.set_meta("magnet_range", range_val)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("자석 - 아이템 자동 수집 범위 %.0f" % range_val)
