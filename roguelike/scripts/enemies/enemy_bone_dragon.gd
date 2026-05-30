extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 120
	attack_damage = 32
	move_speed = 60.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 65
	body_color = Color(0.9, 0.9, 0.8)
	body_size = 20
	super._ready()
