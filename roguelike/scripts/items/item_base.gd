extends Area2D

@export var item_name: String = "Item"
@export var item_color: Color = Color.YELLOW

func _ready() -> void:
	var rect = ColorRect.new()
	rect.size = Vector2(10, 10)
	rect.position = Vector2(-5, -5)
	rect.color = item_color
	add_child(rect)

	var shape = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 8.0
	shape.shape = circle
	add_child(shape)

	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_apply_effect(body)
		queue_free()

func _apply_effect(_player: Node) -> void:
	pass
