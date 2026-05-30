extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 14
	move_speed = 50.0
	chase_range = 180.0
	attack_range = 18.0
	attack_cooldown = 1.1
	exp_reward = 28
	body_color = Color(0.4,0.7,0.2)
	body_size = 13
	super._ready()
