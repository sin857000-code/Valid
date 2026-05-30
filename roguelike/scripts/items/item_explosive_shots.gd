extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 0.5, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.set_meta("explosive_shots", true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("폭발탄! 공격시 범위 폭발")
