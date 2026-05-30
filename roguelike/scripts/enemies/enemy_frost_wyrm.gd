extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 95
	attack_damage = 28
	move_speed = 65.0
	chase_range = 220.0
	attack_range = 24.0
	attack_cooldown = 1.2
	exp_reward = 62
	body_color = Color(0.6,0.8,1.0)
	body_size = 17
	super._ready()
