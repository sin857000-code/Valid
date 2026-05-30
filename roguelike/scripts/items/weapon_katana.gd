extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Katana"
	attack_damage = 26
	attack_range = 50.0
	attack_cooldown = 0.4
	weapon_color = Color(0.9, 0.9, 0.9)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	for body in player.get_tree().get_nodes_in_group("enemies"):
		var d = player.global_position.distance_to(body.global_position)
		if d < attack_range:
			var dir = (body.global_position - player.global_position).normalized()
			if dir.dot(player.get_meta("facing", Vector2.RIGHT)) > 0.3:
				if body.has_method("take_damage"):
					body.take_damage(atk, dir)
