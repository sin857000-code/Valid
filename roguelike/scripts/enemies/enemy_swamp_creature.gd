extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 70
	attack_damage = 20
	move_speed = 55.0
	chase_range = 185.0
	attack_range = 22.0
	attack_cooldown = 1.3
	exp_reward = 44
	body_color = Color(0.3,0.5,0.2)
	body_size = 16
	super._ready()
