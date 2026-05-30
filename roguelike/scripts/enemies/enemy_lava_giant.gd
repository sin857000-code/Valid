extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 120
	attack_damage = 32
	move_speed = 40.0
	chase_range = 190.0
	attack_range = 28.0
	attack_cooldown = 1.8
	exp_reward = 75
	body_color = Color(0.9,0.3,0.0)
	body_size = 21
	super._ready()
