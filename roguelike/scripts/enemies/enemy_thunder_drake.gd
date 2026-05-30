extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 95
	attack_damage = 28
	move_speed = 70.0
	chase_range = 210.0
	attack_range = 24.0
	attack_cooldown = 1.2
	exp_reward = 62
	body_color = Color(0.7,0.9,0.3)
	body_size = 17
	super._ready()
