extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 16
	move_speed = 80.0
	chase_range = 190.0
	attack_range = 16.0
	attack_cooldown = 0.8
	exp_reward = 32
	body_color = Color(0.6,0.6,0.7)
	body_size = 12
	super._ready()
