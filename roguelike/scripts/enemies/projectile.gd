extends Node2D

var _velocity: Vector2 = Vector2.ZERO
var _damage: int = 8
var _lifetime: float = 2.0
var _dot: ColorRect

func setup(direction: Vector2, damage: int, speed: float) -> void:
	_damage = damage
	_velocity = direction.normalized() * speed

	_dot = ColorRect.new()
	_dot.size = Vector2(8, 8)
	_dot.position = Vector2(-4, -4)
	_dot.color = Color(0.2, 1.0, 0.4)
	add_child(_dot)

	# Glowing core
	var glow = ColorRect.new()
	glow.size = Vector2(4, 4)
	glow.position = Vector2(-2, -2)
	glow.color = Color(0.8, 1.0, 0.8, 0.9)
	add_child(glow)

	# Tail
	var tail = ColorRect.new()
	tail.size = Vector2(14, 3)
	tail.position = Vector2(-14, -1)
	tail.color = Color(0.2, 0.9, 0.4, 0.3)
	add_child(tail)

	rotation = direction.angle()
	# Pulse the projectile
	var pulse = create_tween().set_loops()
	pulse.tween_property(_dot, "modulate:a", 0.6, 0.15)
	pulse.tween_property(_dot, "modulate:a", 1.0, 0.15)

func _process(delta: float) -> void:
	position += _velocity * delta
	_lifetime -= delta
	if _lifetime <= 0.0:
		queue_free()
		return

	if has_meta("player_proj") and get_meta("player_proj"):
		# Player-fired: hits enemies
		for enemy in get_tree().get_nodes_in_group("enemy"):
			if global_position.distance_to(enemy.global_position) < 12.0:
				var dmg = get_meta("dmg_override") if has_meta("dmg_override") else _damage
				enemy.take_damage(dmg, global_position)
				_spawn_impact()
				queue_free()
				return
	else:
		# Enemy-fired: hits player
		var player = get_tree().get_first_node_in_group("player")
		if player and global_position.distance_to(player.global_position) < 10.0:
			player.take_damage(_damage)
			_spawn_impact()
			queue_free()

func _spawn_impact() -> void:
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 1.0, 0.5))
