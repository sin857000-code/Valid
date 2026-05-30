extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 130
	attack_damage = 30
	move_speed = 40.0
	chase_range = 185.0
	attack_range = 28.0
	attack_cooldown = 1.7
	exp_reward = 78
	body_color = Color(0.9,0.9,0.8)
	body_size = 21
	super._ready()
