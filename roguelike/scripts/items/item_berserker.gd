extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(1.0, 0.2, 0.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	var stacks = player.get_meta("berserker_stacks") if player.has_meta("berserker_stacks") else 0
	stacks += 1
	player.set_meta("berserker_stacks", stacks)
	player.attack_damage = int(player.attack_damage * 1.3)
	var penalty = int(player.max_health * 0.1)
	player.max_health -= penalty
	player.current_health = min(player.current_health, player.max_health)
	player.health_changed.emit(player.current_health, player.max_health)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("광전사! ATK+30% MaxHP-10%")
