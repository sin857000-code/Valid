extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 35
	attack_damage = 16
	move_speed = 55.0
	chase_range = 210.0
	attack_range = 22.0
	attack_cooldown = 1.3
	exp_reward = 28
	body_color = Color(0.3,0.7,0.2)
	body_size = 11
	super._ready()
