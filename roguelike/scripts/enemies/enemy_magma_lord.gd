extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 110
	attack_damage = 32
	move_speed = 55.0
	chase_range = 210.0
	attack_range = 26.0
	attack_cooldown = 1.5
	exp_reward = 68
	body_color = Color(1.0,0.4,0.0)
	body_size = 19
	super._ready()
