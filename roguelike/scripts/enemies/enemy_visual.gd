extends Node2D

# 적 비주얼: 몸체 + 체력바 + 피격 이펙트
var _body: ColorRect
var _hp_bg: ColorRect
var _hp_bar: ColorRect
var _tween: Tween
var _base_color: Color

func setup(color: Color, size: int = 12) -> void:
	_base_color = color
	var half = size / 2

	# 외곽선
	var outline = ColorRect.new()
	outline.size = Vector2(size + 4, size + 4)
	outline.position = Vector2(-half - 2, -half - 2)
	outline.color = color.darkened(0.4)
	add_child(outline)

	# 몸체
	_body = ColorRect.new()
	_body.size = Vector2(size, size)
	_body.position = Vector2(-half, -half)
	_body.color = color
	add_child(_body)

	# 체력바 배경
	_hp_bg = ColorRect.new()
	_hp_bg.size = Vector2(size + 4, 3)
	_hp_bg.position = Vector2(-half - 2, -half - 7)
	_hp_bg.color = Color(0.2, 0.2, 0.2)
	add_child(_hp_bg)

	# 체력바
	_hp_bar = ColorRect.new()
	_hp_bar.size = Vector2(size + 4, 3)
	_hp_bar.position = Vector2(-half - 2, -half - 7)
	_hp_bar.color = Color(0.2, 0.9, 0.3)
	add_child(_hp_bar)

func update_hp(ratio: float) -> void:
	if _hp_bar == null:
		return
	var full_width = _hp_bg.size.x
	_hp_bar.size.x = full_width * ratio
	_hp_bar.color = Color(1.0 - ratio, ratio * 0.85, 0.1)

func flash_hit() -> void:
	if _tween:
		_tween.kill()
	_body.color = Color.WHITE
	_tween = create_tween()
	_tween.tween_property(_body, "color", _base_color, 0.12)

func death_anim(callback: Callable) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.08)
	_tween.tween_property(self, "scale", Vector2.ZERO, 0.12)
	_tween.tween_callback(callback)
