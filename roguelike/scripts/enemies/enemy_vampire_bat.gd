extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 18
	attack_damage = 6
	move_speed = 100.0
	chase_range = 280.0
	attack_range = 16.0
	attack_cooldown = 0.8
	exp_reward = 12
	body_color = Color(0.4, 0.0, 0.5)
	body_size = 8
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	super.take_damage(amount, source_pos)
	# Heals a little on attack (handled via override of attack in _physics_process)

func _heal_on_attack() -> void:
	if current_health < max_health:
		current_health = min(current_health + 3, max_health)
		if _visual:
			_visual.update_hp(float(current_health) / float(max_health))
