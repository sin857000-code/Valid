extends "res://scripts/items/item_base.gd"

@export var weapon_name: String = "무기"
@export var damage: int = 10
@export var range_radius: float = 30.0
@export var cooldown: float = 0.4

func _apply_effect(player: Node) -> void:
	player.attack_damage = damage
	player.attack_range = range_radius
	player.attack_cooldown = cooldown
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup(weapon_name)
