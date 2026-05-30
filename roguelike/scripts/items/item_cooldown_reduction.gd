extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.3, 0.7, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.attack_cooldown = max(player.attack_cooldown * 0.75, 0.08)
	if player._bomb_cooldown > 0:
		player._bomb_cooldown = max(0.0, player._bomb_cooldown - 2.0)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("쿨다운 감소! 공격속도 +25%")
