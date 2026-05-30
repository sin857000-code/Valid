extends Node2D

var _velocity: Vector2 = Vector2.ZERO
var _damage: int = 8
var _lifetime: float = 2.0
var _color: Color = Color(0.2, 1.0, 0.4)
var _tween: Tween

func _ready() -> void:
	z_index = 20

func setup(direction: Vector2, damage: int, speed: float) -> void:
	_damage = damage
	_velocity = direction.normalized() * speed
	_color = Color(0.2, 1.0, 0.4) if not has_meta("player_proj") else Color(1.0, 0.9, 0.2)
	rotation = direction.angle()
	queue_redraw()
	# Pulse tween
	_tween = create_tween().set_loops()
	_tween.tween_method(_set_alpha, 1.0, 0.5, 0.12)
	_tween.tween_method(_set_alpha, 0.5, 1.0, 0.12)

func _set_alpha(a: float) -> void:
	modulate.a = a

func _draw() -> void:
	# Glow ring
	draw_circle(Vector2.ZERO, 7, Color(_color.r, _color.g, _color.b, 0.25))
	# Main dot
	draw_circle(Vector2.ZERO, 4, _color)
	# Bright core
	draw_circle(Vector2.ZERO, 2, Color(1.0, 1.0, 1.0, 0.9))
	# Tail
	draw_line(Vector2(-12, 0), Vector2(-4, 0), Color(_color.r, _color.g, _color.b, 0.4), 2.0)

func _process(delta: float) -> void:
	position += _velocity * delta
	_lifetime -= delta
	if _lifetime <= 0.0:
		queue_free()
		return

	if has_meta("player_proj") and get_meta("player_proj"):
		for enemy in get_tree().get_nodes_in_group("enemy"):
			if global_position.distance_to(enemy.global_position) < 12.0:
				var dmg = get_meta("dmg_override") if has_meta("dmg_override") else _damage
				enemy.take_damage(dmg, global_position)
				_spawn_impact()
				queue_free()
				return
	else:
		var player = get_tree().get_first_node_in_group("player")
		if player and global_position.distance_to(player.global_position) < 10.0:
			player.take_damage(_damage)
			_spawn_impact()
			queue_free()

func _spawn_impact() -> void:
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 1.0, 0.5))
