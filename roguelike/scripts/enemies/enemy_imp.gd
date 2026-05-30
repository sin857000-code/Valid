extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 25
	attack_damage = 12
	move_speed = 90.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 20
	body_color = Color(0.9, 0.2, 0.1)
	body_size = 12
	super._ready()
