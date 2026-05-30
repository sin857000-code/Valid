extends Area2D

@export var item_name: String = "Item"
@export var item_color: Color = Color.YELLOW

var _rect: ColorRect
var _glow: ColorRect

func _ready() -> void:
	# 외부 발광 테두리
	_glow = ColorRect.new()
	_glow.size = Vector2(14, 14)
	_glow.position = Vector2(-7, -7)
	_glow.color = item_color.lightened(0.3)
	_glow.modulate.a = 0.5
	add_child(_glow)

	# 아이템 본체
	_rect = ColorRect.new()
	_rect.size = Vector2(10, 10)
	_rect.position = Vector2(-5, -5)
	_rect.color = item_color
	add_child(_rect)

	var shape = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 9.0
	shape.shape = circle
	add_child(shape)

	body_entered.connect(_on_body_entered)

	# 펄스 애니메이션
	_start_pulse()

func _start_pulse() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(_glow, "modulate:a", 0.9, 0.6)
	tween.tween_property(_glow, "modulate:a", 0.2, 0.6)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_apply_effect(body)
		queue_free()

func _apply_effect(_player: Node) -> void:
	pass
