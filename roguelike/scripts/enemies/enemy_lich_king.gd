extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 100
	attack_damage = 35
	move_speed = 50.0
	chase_range = 210.0
	attack_range = 26.0
	attack_cooldown = 1.4
	exp_reward = 70
	body_color = Color(0.3,0.0,0.5)
	body_size = 18
	super._ready()
