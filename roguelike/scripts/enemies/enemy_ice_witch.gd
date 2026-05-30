extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 18
	move_speed = 50.0
	chase_range = 220.0
	attack_range = 24.0
	attack_cooldown = 1.4
	exp_reward = 38
	body_color = Color(0.7,0.8,1.0)
	body_size = 13
	super._ready()
