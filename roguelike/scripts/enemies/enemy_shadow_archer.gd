extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 42
	attack_damage = 20
	move_speed = 60.0
	chase_range = 230.0
	attack_range = 180.0
	attack_cooldown = 1.6
	exp_reward = 36
	body_color = Color(0.2,0.1,0.3)
	body_size = 12
	super._ready()
