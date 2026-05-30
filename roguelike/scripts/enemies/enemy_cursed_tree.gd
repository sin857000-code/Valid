extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 90
	attack_damage = 20
	move_speed = 20.0
	chase_range = 170.0
	attack_range = 30.0
	attack_cooldown = 1.5
	exp_reward = 52
	body_color = Color(0.4,0.6,0.2)
	body_size = 18
	super._ready()
