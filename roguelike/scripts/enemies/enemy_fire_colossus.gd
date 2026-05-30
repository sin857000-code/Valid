extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 130
	attack_damage = 35
	move_speed = 45.0
	chase_range = 190.0
	attack_range = 28.0
	attack_cooldown = 2.0
	exp_reward = 80
	body_color = Color(1.0,0.3,0.0)
	body_size = 22
	super._ready()
