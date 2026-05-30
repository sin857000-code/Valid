extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.1, 0.7, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	var thorns = player.get_meta("thorns_dmg") if player.has_meta("thorns_dmg") else 0
	thorns += 5
	player.set_meta("thorns_dmg", thorns)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("가시 갑옷 - 피격시 %d 반사" % thorns)
