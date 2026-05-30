extends Node2D

var _velocity: Vector2 = Vector2.ZERO
var _damage: int = 8
var _lifetime: float = 2.0
var _dot: ColorRect

func setup(direction: Vector2, damage: int, speed: float) -> void:
	_damage = damage
	_velocity = direction.normalized() * speed

	_dot = ColorRect.new()
	_dot.size = Vector2(6, 6)
	_dot.position = Vector2(-3, -3)
	_dot.color = Color(0.3, 1.0, 0.5)
	add_child(_dot)

	# 꼬리 잔상
	var tail = ColorRect.new()
	tail.size = Vector2(10, 3)
	tail.position = Vector2(-10, -1)
	tail.color = Color(0.3, 1.0, 0.5, 0.4)
	add_child(tail)

	rotation = direction.angle()

func _process(delta: float) -> void:
	position += _velocity * delta
	_lifetime -= delta
	if _lifetime <= 0.0:
		queue_free()
		return

	# 플레이어 충돌 체크
	var player = get_tree().get_first_node_in_group("player")
	if player and global_position.distance_to(player.global_position) < 10.0:
		player.take_damage(_damage)
		_spawn_impact()
		queue_free()

func _spawn_impact() -> void:
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 1.0, 0.5))
