extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 22
	move_speed = 52.0
	chase_range = 215.0
	attack_range = 22.0
	attack_cooldown = 1.3
	exp_reward = 40
	body_color = Color(0.8,0.95,1.0)
	body_size = 14
	super._ready()
