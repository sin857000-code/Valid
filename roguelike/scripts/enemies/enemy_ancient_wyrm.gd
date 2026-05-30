extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 140
	attack_damage = 36
	move_speed = 55.0
	chase_range = 215.0
	attack_range = 26.0
	attack_cooldown = 1.4
	exp_reward = 88
	body_color = Color(0.6,0.5,0.2)
	body_size = 22
	super._ready()
