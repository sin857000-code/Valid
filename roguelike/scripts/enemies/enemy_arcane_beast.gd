extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 75
	attack_damage = 25
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 52
	body_color = Color(0.6,0.2,0.8)
	body_size = 15
	super._ready()
