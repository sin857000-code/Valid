extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 110
	attack_damage = 34
	move_speed = 55.0
	chase_range = 215.0
	attack_range = 26.0
	attack_cooldown = 1.3
	exp_reward = 70
	body_color = Color(0.2,0.0,0.2)
	body_size = 19
	super._ready()
