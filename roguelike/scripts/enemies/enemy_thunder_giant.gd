extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 135
	attack_damage = 32
	move_speed = 45.0
	chase_range = 190.0
	attack_range = 28.0
	attack_cooldown = 1.9
	exp_reward = 82
	body_color = Color(0.8,0.9,0.3)
	body_size = 21
	super._ready()
