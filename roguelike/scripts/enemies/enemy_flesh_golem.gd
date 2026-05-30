extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 100
	attack_damage = 26
	move_speed = 50.0
	chase_range = 190.0
	attack_range = 26.0
	attack_cooldown = 1.5
	exp_reward = 62
	body_color = Color(0.7,0.4,0.3)
	body_size = 18
	super._ready()
