extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 26
	move_speed = 60.0
	chase_range = 200.0
	attack_range = 24.0
	attack_cooldown = 1.1
	exp_reward = 55
	body_color = Color(0.3,0.5,0.2)
	body_size = 16
	super._ready()
