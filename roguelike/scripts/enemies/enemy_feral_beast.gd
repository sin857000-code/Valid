extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 22
	move_speed = 90.0
	chase_range = 210.0
	attack_range = 18.0
	attack_cooldown = 0.8
	exp_reward = 38
	body_color = Color(0.5,0.3,0.1)
	body_size = 14
	super._ready()
