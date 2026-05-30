extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 28
	move_speed = 65.0
	chase_range = 205.0
	attack_range = 24.0
	attack_cooldown = 1.0
	exp_reward = 55
	body_color = Color(0.6,0.1,0.6)
	body_size = 16
	super._ready()
