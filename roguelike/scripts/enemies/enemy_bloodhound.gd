extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 22
	attack_damage = 9
	move_speed = 130.0
	chase_range = 999.0
	attack_range = 17.0
	attack_cooldown = 0.7
	exp_reward = 14
	body_color = Color(0.6, 0.2, 0.1)
	body_size = 9
	super._ready()
