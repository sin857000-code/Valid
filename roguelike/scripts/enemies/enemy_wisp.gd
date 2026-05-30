extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 15
	attack_damage = 5
	move_speed = 120.0
	chase_range = 350.0
	attack_range = 15.0
	attack_cooldown = 0.7
	exp_reward = 10
	body_color = Color(0.9, 0.9, 0.3)
	body_size = 6
	super._ready()
	modulate.a = 0.75

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		if _player == null:
			_player = get_tree().get_first_node_in_group("player")
		return
	# Wisps orbit the player from a distance
	var dist = global_position.distance_to(_player.global_position)
	var angle = global_position.angle_to_point(_player.global_position)
	if dist > 60.0:
		velocity = (_player.global_position - global_position).normalized() * move_speed
	else:
		# Orbit
		var orbit_angle = angle + PI / 2.0
		velocity = Vector2(cos(orbit_angle), sin(orbit_angle)) * move_speed
	_attack_timer -= delta
	if dist < attack_range and _attack_timer <= 0.0:
		_attack_timer = attack_cooldown
		_player.take_damage(attack_damage)
	move_and_slide()
