extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 32
	attack_damage = 16
	move_speed = 95.0
	chase_range = 200.0
	attack_range = 14.0
	attack_cooldown = 0.65
	exp_reward = 26
	body_color = Color(1.0,0.3,0.0)
	body_size = 10
	super._ready()
