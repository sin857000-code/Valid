extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 75
	attack_damage = 28
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 45
	body_color = Color(0.8, 0.0, 0.0)
	body_size = 16
	super._ready()
