extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 60
	attack_damage = 22
	move_speed = 65.0
	chase_range = 215.0
	attack_range = 20.0
	attack_cooldown = 1.0
	exp_reward = 44
	body_color = Color(0.4,0.6,0.3)
	body_size = 14
	super._ready()
