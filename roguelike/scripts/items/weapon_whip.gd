extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Whip"
	attack_damage = 14
	attack_range = 95.0
	attack_cooldown = 0.7
	weapon_color = Color(0.8, 0.5, 0.2)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	for body in player.get_tree().get_nodes_in_group("enemies"):
		if player.global_position.distance_to(body.global_position) < attack_range:
			if body.has_method("take_damage"):
				body.take_damage(atk, (body.global_position - player.global_position).normalized())
