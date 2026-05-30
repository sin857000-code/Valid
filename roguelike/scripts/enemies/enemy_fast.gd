extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 15
	attack_damage = 3
	move_speed = 120.0
	chase_range = 250.0
	attack_range = 14.0
	exp_reward = 8
	body_color = Color.ORANGE
	super._ready()
