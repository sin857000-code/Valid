extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.8, 0.9, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.set_meta("mirror_shield", true)
	player.set_meta("shield", true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("거울 방패 - 첫 피격 무효 + 반사!")
