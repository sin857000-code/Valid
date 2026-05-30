extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 35
	attack_damage = 12
	move_speed = 120.0
	chase_range = 230.0
	attack_range = 16.0
	attack_cooldown = 0.6
	exp_reward = 25
	body_color = Color(0.9,1.0,0.9)
	body_size = 10
	super._ready()
