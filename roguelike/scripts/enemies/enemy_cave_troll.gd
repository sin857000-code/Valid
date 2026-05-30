extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 90
	attack_damage = 24
	move_speed = 50.0
	chase_range = 180.0
	attack_range = 26.0
	attack_cooldown = 1.6
	exp_reward = 50
	body_color = Color(0.4,0.5,0.3)
	body_size = 18
	super._ready()
