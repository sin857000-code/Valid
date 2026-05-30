extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 50
	attack_damage = 20
	move_speed = 75.0
	chase_range = 190.0
	attack_range = 16.0
	attack_cooldown = 0.9
	exp_reward = 35
	body_color = Color(0.8,0.6,0.1)
	body_size = 13
	super._ready()
