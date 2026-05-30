extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 35
	attack_damage = 16
	move_speed = 105.0
	chase_range = 230.0
	attack_range = 14.0
	attack_cooldown = 0.6
	exp_reward = 26
	body_color = Color(0.4, 0.3, 0.1)
	body_size = 11
	super._ready()
