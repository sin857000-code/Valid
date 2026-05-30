extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 105
	attack_damage = 34
	move_speed = 45.0
	chase_range = 220.0
	attack_range = 26.0
	attack_cooldown = 1.4
	exp_reward = 72
	body_color = Color(0.4,0.1,0.6)
	body_size = 18
	super._ready()
