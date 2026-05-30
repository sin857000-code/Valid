extends Area2D

const TILE = 16
const DAMAGE_INTERVAL = 0.8
const DAMAGE = 8

var _timer: float = 0.0
var _player_inside: bool = false
var _rect: ColorRect
var _cross1: ColorRect
var _cross2: ColorRect

func _ready() -> void:
	add_to_group("trap")
	var col = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(TILE - 2, TILE - 2)
	col.shape = shape
	add_child(col)

	_rect = ColorRect.new()
	_rect.size = Vector2(TILE, TILE)
	_rect.position = Vector2(-TILE / 2, -TILE / 2)
	_rect.color = Color(0.35, 0.05, 0.05, 0.7)
	add_child(_rect)

	_cross1 = ColorRect.new()
	_cross1.size = Vector2(TILE - 2, 2)
	_cross1.position = Vector2(-TILE / 2 + 1, -1)
	_cross1.color = Color(0.9, 0.1, 0.1, 0.9)
	_cross1.rotation = deg_to_rad(45)
	add_child(_cross1)

	_cross2 = ColorRect.new()
	_cross2.size = Vector2(TILE - 2, 2)
	_cross2.position = Vector2(-TILE / 2 + 1, -1)
	_cross2.color = Color(0.9, 0.1, 0.1, 0.9)
	_cross2.rotation = deg_to_rad(-45)
	add_child(_cross2)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_player_inside = true
		_timer = 0.0

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		_player_inside = false

func _process(delta: float) -> void:
	if not _player_inside:
		return
	_timer += delta
	if _timer >= DAMAGE_INTERVAL:
		_timer = 0.0
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.take_damage(DAMAGE)
			_rect.color = Color(0.8, 0.1, 0.1, 0.9)
			var tween = create_tween()
			tween.tween_property(_rect, "color", Color(0.35, 0.05, 0.05, 0.7), 0.3)
