extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 35
	attack_damage = 14
	move_speed = 100.0
	chase_range = 220.0
	attack_range = 14.0
	attack_cooldown = 0.7
	exp_reward = 25
	body_color = Color(0.2,0.1,0.3)
	body_size = 11
	super._ready()
