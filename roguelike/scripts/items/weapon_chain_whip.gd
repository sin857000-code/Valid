extends "res://scripts/items/weapon_base.gd"

const MAX_CHAIN_TARGETS = 3
const CHAIN_RANGE = 110.0

func _ready() -> void:
	weapon_name = "Chain Whip"
	attack_damage = 24
	attack_range = CHAIN_RANGE
	attack_cooldown = 1.0
	weapon_color = Color(0.6, 0.45, 0.1)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	var all_enemies = player.get_tree().get_nodes_in_group("enemies")
	var in_range = []
	for body in all_enemies:
		if player.global_position.distance_to(body.global_position) <= CHAIN_RANGE:
			in_range.append(body)
	in_range.sort_custom(func(a, b):
		return player.global_position.distance_to(a.global_position) < player.global_position.distance_to(b.global_position)
	)
	var hit_count = 0
	var last_pos = player.global_position
	for body in in_range:
		if hit_count >= MAX_CHAIN_TARGETS:
			break
		if last_pos.distance_to(body.global_position) <= CHAIN_RANGE:
			if body.has_method("take_damage"):
				body.take_damage(atk, (body.global_position - last_pos).normalized())
			last_pos = body.global_position
			hit_count += 1
