extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 85
	attack_damage = 22
	move_speed = 45.0
	chase_range = 190.0
	attack_range = 24.0
	attack_cooldown = 1.5
	exp_reward = 55
	body_color = Color(0.5,0.2,0.9)
	body_size = 17
	super._ready()
