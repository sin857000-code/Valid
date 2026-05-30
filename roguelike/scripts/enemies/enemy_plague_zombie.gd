extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 16
	move_speed = 40.0
	chase_range = 170.0
	attack_range = 20.0
	attack_cooldown = 1.3
	exp_reward = 30
	body_color = Color(0.4,0.5,0.2)
	body_size = 14
	super._ready()
