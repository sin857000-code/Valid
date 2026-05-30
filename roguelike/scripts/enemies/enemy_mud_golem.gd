extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 22
	move_speed = 40.0
	chase_range = 180.0
	attack_range = 22.0
	attack_cooldown = 1.5
	exp_reward = 48
	body_color = Color(0.4,0.3,0.1)
	body_size = 17
	super._ready()
