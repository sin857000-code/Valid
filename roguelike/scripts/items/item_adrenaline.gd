extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 0.1, 0.3)
	super._ready()

func _apply_effect(player: Node) -> void:
	# More damage when HP is low
	player.set_meta("adrenaline", true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("아드레날린 - HP 낮을수록 공격력 증가!")
