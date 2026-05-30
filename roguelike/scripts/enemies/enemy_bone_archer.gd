extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 40
	attack_damage = 18
	move_speed = 50.0
	chase_range = 240.0
	attack_range = 180.0
	attack_cooldown = 1.5
	exp_reward = 32
	body_color = Color(0.9,0.9,0.7)
	body_size = 12
	super._ready()
