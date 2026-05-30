extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 30
	attack_damage = 15
	move_speed = 100.0
	chase_range = 210.0
	attack_range = 14.0
	attack_cooldown = 0.6
	exp_reward = 24
	body_color = Color(0.8,0.1,0.8)
	body_size = 10
	super._ready()
