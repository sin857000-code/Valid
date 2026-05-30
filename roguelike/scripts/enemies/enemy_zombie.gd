extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 12
	move_speed = 35.0
	chase_range = 170.0
	attack_range = 20.0
	attack_cooldown = 1.4
	exp_reward = 20
	body_color = Color(0.3, 0.5, 0.2)
	body_size = 13
	super._ready()
