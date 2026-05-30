extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Flame Sword"
	attack_damage = 20
	attack_range = 55.0
	attack_cooldown = 0.8
	weapon_color = Color(1.0, 0.4, 0.0)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	for body in player.get_tree().get_nodes_in_group("enemies"):
		var d = player.global_position.distance_to(body.global_position)
		if d < attack_range:
			if body.has_method("take_damage"):
				body.take_damage(atk, (body.global_position - player.global_position).normalized())
			if body.has_node("StatusEffect"):
				body.get_node("StatusEffect").apply_poison(5, 3.0)
