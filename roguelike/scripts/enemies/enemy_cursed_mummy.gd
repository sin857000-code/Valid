extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 65
	attack_damage = 22
	move_speed = 45.0
	chase_range = 190.0
	attack_range = 22.0
	attack_cooldown = 1.3
	exp_reward = 42
	body_color = Color(0.7,0.6,0.4)
	body_size = 15
	super._ready()
