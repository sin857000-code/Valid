extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 120
	attack_damage = 28
	move_speed = 35.0
	chase_range = 180.0
	attack_range = 28.0
	attack_cooldown = 1.8
	exp_reward = 72
	body_color = Color(0.6,0.6,0.7)
	body_size = 20
	super._ready()
