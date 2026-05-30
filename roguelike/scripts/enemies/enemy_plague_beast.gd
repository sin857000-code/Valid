extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 75
	attack_damage = 24
	move_speed = 65.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 50
	body_color = Color(0.5,0.7,0.2)
	body_size = 16
	super._ready()
