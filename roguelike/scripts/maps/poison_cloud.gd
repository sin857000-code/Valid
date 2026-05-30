extends Area2D

const RADIUS = 55.0
const DAMAGE_INTERVAL = 0.6
const DAMAGE = 5
const DURATION = 4.0

var _timer: float = 0.0
var _damage_timer: float = 0.0
var _visual: ColorRect

func _ready() -> void:
	_visual = ColorRect.new()
	_visual.size = Vector2(RADIUS * 2, RADIUS * 2)
	_visual.position = Vector2(-RADIUS, -RADIUS)
	_visual.color = Color(0.2, 0.8, 0.2, 0.35)
	add_child(_visual)

	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = RADIUS
	col.shape = shape
	add_child(col)

	# Fade out over lifetime
	var tween = _visual.create_tween()
	tween.tween_property(_visual, "modulate:a", 0.0, DURATION)
	tween.tween_callback(queue_free)

func _process(delta: float) -> void:
	_timer += delta
	_damage_timer += delta
	if _damage_timer >= DAMAGE_INTERVAL:
		_damage_timer = 0.0
		var player = get_tree().get_first_node_in_group("player")
		if player and global_position.distance_to(player.global_position) < RADIUS:
			player.take_damage(DAMAGE)
