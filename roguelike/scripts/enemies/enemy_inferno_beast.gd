extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 90
	attack_damage = 28
	move_speed = 72.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 60
	body_color = Color(1.0,0.3,0.0)
	body_size = 17
	super._ready()
