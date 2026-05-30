extends Node2D

var _base_color: Color = Color(0.9, 0.2, 0.2)
var _flash_color: Color = Color(0.9, 0.2, 0.2)
var _hp_ratio: float = 1.0
var _size: float = 12.0
var _tween: Tween

func setup(color: Color, size: int) -> void:
	z_index = 10
	_base_color = color
	_flash_color = color
	_size = float(size)
	queue_redraw()

func _draw() -> void:
	var r = _size / 2.0
	# Shadow
	draw_circle(Vector2(1, 1), r, Color(0, 0, 0, 0.3))
	# Body ring
	draw_circle(Vector2.ZERO, r, _flash_color.darkened(0.35))
	# Body fill
	draw_circle(Vector2.ZERO, r - 2, _flash_color)
	# Pixel highlight
	draw_circle(Vector2(-r * 0.3, -r * 0.3), maxf(1.5, r * 0.25), _flash_color.lightened(0.4))
	# Eyes
	if r >= 5.0:
		draw_circle(Vector2(r * 0.4, -r * 0.3), 1.5, Color.WHITE)
		draw_circle(Vector2(r * 0.4,  r * 0.3), 1.5, Color.WHITE)
		draw_circle(Vector2(r * 0.4, -r * 0.3), 0.8, Color(0.1, 0.0, 0.0))
		draw_circle(Vector2(r * 0.4,  r * 0.3), 0.8, Color(0.1, 0.0, 0.0))
	# HP bar
	var bar_w = _size + 4.0
	var bar_y = -r - 7.0
	draw_rect(Rect2(-bar_w / 2.0, bar_y, bar_w, 3), Color(0.15, 0.15, 0.15))
	draw_rect(Rect2(-bar_w / 2.0, bar_y, bar_w * _hp_ratio, 3),
		Color(1.0 - _hp_ratio, _hp_ratio * 0.85, 0.1))

func update_hp(ratio: float) -> void:
	_hp_ratio = ratio
	queue_redraw()

func flash_hit() -> void:
	if _tween:
		_tween.kill()
	_flash_color = Color.WHITE
	queue_redraw()
	_tween = create_tween()
	_tween.tween_method(_set_color, Color.WHITE, _base_color, 0.12)

func _set_color(c: Color) -> void:
	_flash_color = c
	queue_redraw()

func death_anim(callback: Callable) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.08)
	_tween.tween_property(self, "scale", Vector2.ZERO, 0.12)
	_tween.tween_callback(callback)
