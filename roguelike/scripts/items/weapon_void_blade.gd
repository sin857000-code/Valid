extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Void Blade"
	attack_damage = 40
	attack_range = 60.0
	attack_cooldown = 0.9
	weapon_color = Color(0.15, 0.0, 0.3)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	var hit_dir = player.velocity.normalized() if player.velocity.length() > 1.0 else Vector2.RIGHT
	if player.has_meta("facing_dir"):
		hit_dir = player.get_meta("facing_dir")
	for body in player.get_tree().get_nodes_in_group("enemies"):
		var to_enemy = body.global_position - player.global_position
		if to_enemy.length() > attack_range:
			continue
		var angle = hit_dir.angle_to(to_enemy.normalized())
		if abs(angle) <= deg_to_rad(60.0):
			if body.has_method("take_damage"):
				body.take_damage(atk, to_enemy.normalized())
