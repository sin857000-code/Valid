extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 40
	attack_damage = 15
	move_speed = 75.0
	chase_range = 190.0
	attack_range = 16.0
	attack_cooldown = 0.8
	exp_reward = 30
	body_color = Color(0.9,0.3,0.0)
	body_size = 12
	super._ready()
