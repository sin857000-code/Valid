extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 60
	attack_damage = 18
	move_speed = 90.0
	chase_range = 230.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 38
	body_color = Color(0.5, 0.3, 0.7)
	body_size = 16
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
