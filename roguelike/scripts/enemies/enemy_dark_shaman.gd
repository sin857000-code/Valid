extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 20
	move_speed = 50.0
	chase_range = 220.0
	attack_range = 24.0
	attack_cooldown = 1.4
	exp_reward = 40
	body_color = Color(0.4,0.2,0.5)
	body_size = 14
	super._ready()
