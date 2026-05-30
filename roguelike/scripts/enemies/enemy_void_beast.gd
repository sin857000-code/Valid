extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 25
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 55
	body_color = Color(0.2,0.0,0.3)
	body_size = 16
	super._ready()
