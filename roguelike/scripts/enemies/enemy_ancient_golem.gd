extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 150
	attack_damage = 35
	move_speed = 30.0
	chase_range = 180.0
	attack_range = 30.0
	attack_cooldown = 2.2
	exp_reward = 90
	body_color = Color(0.7,0.6,0.4)
	body_size = 23
	super._ready()
