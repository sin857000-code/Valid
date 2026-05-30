extends Node2D

# 플레이어 비주얼: 몸체 + 방향 표시 + 피격 이펙트
var _body: ColorRect
var _dir_dot: ColorRect
var _tween: Tween

const COLOR_BODY    = Color(0.25, 0.55, 1.0)
const COLOR_OUTLINE = Color(0.5, 0.75, 1.0)
const COLOR_DOT     = Color(1.0, 1.0, 1.0)

func _ready() -> void:
	# 외곽선
	var outline = ColorRect.new()
	outline.size = Vector2(16, 16)
	outline.position = Vector2(-8, -8)
	outline.color = COLOR_OUTLINE
	add_child(outline)

	# 몸체
	_body = ColorRect.new()
	_body.size = Vector2(12, 12)
	_body.position = Vector2(-6, -6)
	_body.color = COLOR_BODY
	add_child(_body)

	# 방향 점
	_dir_dot = ColorRect.new()
	_dir_dot.size = Vector2(4, 4)
	_dir_dot.position = Vector2(4, -2)
	_dir_dot.color = COLOR_DOT
	add_child(_dir_dot)

func update_facing(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		return
	var angle = dir.angle()
	rotation = angle

func flash_hit() -> void:
	if _tween:
		_tween.kill()
	_body.color = Color.WHITE
	_tween = create_tween()
	_tween.tween_property(_body, "color", COLOR_BODY, 0.15)

func flash_attack() -> void:
	if _tween:
		_tween.kill()
	_body.color = Color.YELLOW
	_tween = create_tween()
	_tween.tween_property(_body, "color", COLOR_BODY, 0.1)

func show_attack_range(range_px: float) -> void:
	var ring = ColorRect.new()
	ring.size = Vector2(range_px * 2, range_px * 2)
	ring.position = Vector2(-range_px, -range_px)
	ring.color = Color(1.0, 1.0, 0.3, 0.18)
	add_child(ring)
	var t = ring.create_tween().set_parallel(true)
	t.tween_property(ring, "scale", Vector2(1.3, 1.3), 0.2)
	t.tween_property(ring, "modulate:a", 0.0, 0.2)
	t.tween_callback(ring.queue_free).set_delay(0.2)
