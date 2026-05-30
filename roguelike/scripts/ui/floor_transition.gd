extends CanvasLayer

# 층 전환 페이드 이펙트
var _rect: ColorRect

func _ready() -> void:
	layer = 10
	_rect = ColorRect.new()
	_rect.color = Color.BLACK
	_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_rect.modulate.a = 0.0
	add_child(_rect)

func fade_in(callback: Callable) -> void:
	var tween = create_tween()
	tween.tween_property(_rect, "modulate:a", 1.0, 0.3)
	tween.tween_callback(callback)

func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(_rect, "modulate:a", 0.0, 0.4)
