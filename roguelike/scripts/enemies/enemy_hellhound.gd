extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 22
	move_speed = 120.0
	chase_range = 240.0
	attack_range = 16.0
	attack_cooldown = 0.7
	exp_reward = 30
	body_color = Color(0.9, 0.2, 0.0)
	body_size = 13
	super._ready()
