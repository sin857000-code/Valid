extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.3, 0.5, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.set_meta("dash_attack", true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("대시 공격! 대시 중 적에게 피해")
