extends "res://scripts/items/item_base.gd"

@export var weapon_name: String = "무기"
@export var damage: int = 10
@export var range_radius: float = 30.0
@export var cooldown: float = 0.4

func _apply_effect(player: Node) -> void:
	var upgrade_key = "weapon_" + weapon_name
	var is_upgrade = player.has_meta(upgrade_key)
	if is_upgrade:
		player.attack_damage = int(player.attack_damage * 1.2)
		player.attack_range = player.attack_range * 1.1
		player.attack_cooldown = max(player.attack_cooldown * 0.9, 0.1)
	else:
		player.attack_damage = damage
		player.attack_range = range_radius
		player.attack_cooldown = cooldown
		# Clear old weapon meta
		for key in player.get_meta_list():
			if str(key).begins_with("weapon_"):
				player.remove_meta(key)
	player.set_meta(upgrade_key, true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		var label = (weapon_name + " ★ UPGRADE!") if is_upgrade else ("장착: " + weapon_name)
		hud.show_weapon_pickup(label)
