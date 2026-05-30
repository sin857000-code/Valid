extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 85
	attack_damage = 30
	move_speed = 68.0
	chase_range = 215.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 58
	body_color = Color(0.3,0.0,0.4)
	body_size = 16
	super._ready()
