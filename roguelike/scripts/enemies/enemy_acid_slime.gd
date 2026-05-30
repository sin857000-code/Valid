extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 38
	attack_damage = 14
	move_speed = 60.0
	chase_range = 180.0
	attack_range = 16.0
	attack_cooldown = 1.0
	exp_reward = 26
	body_color = Color(0.5,0.9,0.2)
	body_size = 12
	super._ready()
