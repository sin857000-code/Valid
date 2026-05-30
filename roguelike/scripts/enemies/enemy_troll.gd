extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 110
	attack_damage = 26
	move_speed = 45.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 55
	body_color = Color(0.2, 0.5, 0.1)
	body_size = 19
	super._ready()
