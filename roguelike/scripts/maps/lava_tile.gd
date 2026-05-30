extends Area2D

const DAMAGE = 8
const DAMAGE_INTERVAL = 0.5

var _damage_timer: float = 0.0
var _visual: ColorRect

func _ready() -> void:
	_visual = ColorRect.new()
	_visual.size = Vector2(14, 14)
	_visual.position = Vector2(-7, -7)
	_visual.color = Color(1.0, 0.3, 0.0, 0.85)
	add_child(_visual)

	var col = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(14, 14)
	col.shape = shape
	add_child(col)

	var pulse = _visual.create_tween().set_loops()
	pulse.tween_property(_visual, "color", Color(1.0, 0.6, 0.0, 0.9), 0.4)
	pulse.tween_property(_visual, "color", Color(1.0, 0.2, 0.0, 0.75), 0.4)

func _process(delta: float) -> void:
	_damage_timer += delta
	if _damage_timer >= DAMAGE_INTERVAL:
		_damage_timer = 0.0
		var player = get_tree().get_first_node_in_group("player")
		if player and global_position.distance_to(player.global_position) < 12.0:
			player.take_damage(DAMAGE)
