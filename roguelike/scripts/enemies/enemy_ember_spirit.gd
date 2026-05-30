extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 40
	attack_damage = 14
	move_speed = 90.0
	chase_range = 210.0
	attack_range = 16.0
	attack_cooldown = 0.75
	exp_reward = 30
	body_color = Color(1.0,0.5,0.1)
	body_size = 11
	super._ready()
