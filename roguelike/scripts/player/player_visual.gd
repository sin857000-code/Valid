extends Node2D

var _base_color: Color = Color(0.25, 0.55, 1.0)
var _flash_color: Color = Color(0.25, 0.55, 1.0)
var _tween: Tween

func _ready() -> void:
	z_index = 10
	_flash_color = _base_color

func _draw() -> void:
	# Shadow
	draw_circle(Vector2(1, 1), 7, Color(0, 0, 0, 0.35))
	# Body outer ring
	draw_circle(Vector2.ZERO, 7, _flash_color.darkened(0.3))
	# Body fill
	draw_circle(Vector2.ZERO, 5, _flash_color)
	# Bright highlight
	draw_circle(Vector2(-2, -2), 2, _flash_color.lightened(0.4))
	# Direction eye dot
	draw_circle(Vector2(4, 0), 2, Color.WHITE)
	draw_circle(Vector2(4, 0), 1, Color(0.1, 0.1, 0.8))

func update_facing(dir: Vector2) -> void:
	if dir != Vector2.ZERO:
		rotation = dir.angle()

func flash_hit() -> void:
	if _tween:
		_tween.kill()
	_flash_color = Color.WHITE
	queue_redraw()
	_tween = create_tween()
	_tween.tween_method(_set_color, Color.WHITE, _base_color, 0.15)

func _set_color(c: Color) -> void:
	_flash_color = c
	queue_redraw()

func flash_attack() -> void:
	if _tween:
		_tween.kill()
	_flash_color = Color.YELLOW
	queue_redraw()
	_tween = create_tween()
	_tween.tween_method(_set_color, Color.YELLOW, _base_color, 0.1)

func show_attack_range(_range_px: float) -> void:
	pass
