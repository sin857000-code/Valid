extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 20
	move_speed = 48.0
	chase_range = 220.0
	attack_range = 24.0
	attack_cooldown = 1.3
	exp_reward = 34
	body_color = Color(0.9,0.9,0.75)
	body_size = 13
	super._ready()
