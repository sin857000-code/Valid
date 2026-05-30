extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 1.0, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	if not player.has_meta("second_chance"):
		player.set_meta("second_chance", true)
		var hud = player.get_tree().get_first_node_in_group("hud")
		if hud:
			hud.show_weapon_pickup("부활 준비 완료!")
	else:
		# Already have one - heal instead
		player.heal(int(player.max_health * 0.2))
