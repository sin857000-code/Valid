extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 75
	attack_damage = 24
	move_speed = 70.0
	chase_range = 215.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 52
	body_color = Color(0.1,0.0,0.3)
	body_size = 15
	super._ready()
