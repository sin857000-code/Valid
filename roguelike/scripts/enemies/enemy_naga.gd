extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 60
	attack_damage = 18
	move_speed = 70.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 40
	body_color = Color(0.2, 0.7, 0.4)
	body_size = 12
	super._ready()
