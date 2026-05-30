extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 28
	move_speed = 80.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 50
	body_color = Color(0.8, 0.8, 1.0)
	body_size = 17
	super._ready()
