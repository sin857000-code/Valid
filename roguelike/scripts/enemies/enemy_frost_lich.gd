extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 90
	attack_damage = 28
	move_speed = 50.0
	chase_range = 215.0
	attack_range = 24.0
	attack_cooldown = 1.3
	exp_reward = 60
	body_color = Color(0.5,0.7,1.0)
	body_size = 17
	super._ready()
