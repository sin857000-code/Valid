extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 95
	attack_damage = 28
	move_speed = 55.0
	chase_range = 200.0
	attack_range = 24.0
	attack_cooldown = 1.1
	exp_reward = 58
	body_color = Color(0.6,0.5,0.0)
	body_size = 18
	super._ready()
