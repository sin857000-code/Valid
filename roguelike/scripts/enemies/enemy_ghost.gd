extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 22
	attack_damage = 8
	move_speed = 65.0
	chase_range = 300.0
	attack_range = 20.0
	attack_cooldown = 1.0
	exp_reward = 15
	body_color = Color(0.8, 0.8, 1.0)
	body_size = 10
	super._ready()
	modulate.a = 0.6

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	# Ghosts move through walls (ignore collision by using velocity directly)
	# Just override movement to go directly toward player
	if _dying or _player == null:
		return
	var dist = global_position.distance_to(_player.global_position)
	if dist < chase_range and dist > attack_range:
		global_position += (_player.global_position - global_position).normalized() * move_speed * delta
