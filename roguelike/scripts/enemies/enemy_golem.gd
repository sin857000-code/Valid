extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 90
	attack_damage = 22
	move_speed = 25.0
	chase_range = 150.0
	attack_range = 28.0
	attack_cooldown = 2.0
	exp_reward = 40
	body_color = Color(0.6, 0.5, 0.4)
	body_size = 22
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	# Damage reduction: takes 60% damage
	super.take_damage(max(1, int(amount * 0.6)), source_pos)
