extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 90
	attack_damage = 30
	move_speed = 65.0
	chase_range = 220.0
	attack_range = 24.0
	attack_cooldown = 1.0
	exp_reward = 60
	body_color = Color(0.1,0.1,0.1)
	body_size = 16
	super._ready()
