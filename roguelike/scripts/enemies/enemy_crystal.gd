extends "res://scripts/enemies/enemy_base.gd"

const REFLECT_RATE = 0.5

func _ready() -> void:
	max_health = 30
	attack_damage = 8
	move_speed = 35.0
	chase_range = 160.0
	attack_range = 16.0
	attack_cooldown = 1.8
	exp_reward = 18
	body_color = Color(0.7, 0.9, 1.0)
	body_size = 12
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	# Reflect 50% of damage back to all nearby enemies
	var reflected = int(amount * REFLECT_RATE)
	for body in get_tree().get_nodes_in_group("enemy"):
		if body != self and body.global_position.distance_to(global_position) < 50.0:
			body.take_damage(reflected, global_position)
	super.take_damage(amount, source_pos)
