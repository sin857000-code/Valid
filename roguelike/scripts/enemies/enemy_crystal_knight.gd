extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 75
	attack_damage = 24
	move_speed = 55.0
	chase_range = 195.0
	attack_range = 24.0
	attack_cooldown = 1.2
	exp_reward = 52
	body_color = Color(0.7,0.9,1.0)
	body_size = 16
	super._ready()
