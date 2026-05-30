extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 100
	attack_damage = 30
	move_speed = 40.0
	chase_range = 180.0
	attack_range = 28.0
	attack_cooldown = 1.8
	exp_reward = 45
	body_color = Color(0.3, 0.6, 0.2)
	body_size = 20
	super._ready()
