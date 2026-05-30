extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 28
	attack_damage = 14
	move_speed = 95.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 22
	body_color = Color(1.0, 0.4, 0.0)
	body_size = 12
	super._ready()
