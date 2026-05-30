extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 85
	attack_damage = 24
	move_speed = 55.0
	chase_range = 180.0
	attack_range = 24.0
	attack_cooldown = 1.4
	exp_reward = 50
	body_color = Color(0.3,0.6,0.2)
	body_size = 17
	super._ready()
