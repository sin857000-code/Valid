extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 85
	attack_damage = 26
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 56
	body_color = Color(0.6,0.0,0.6)
	body_size = 17
	super._ready()
