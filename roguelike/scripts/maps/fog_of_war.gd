extends Node2D

# 시야 제한 (Fog of War)
# 플레이어 주변만 밝게, 나머지는 어둡게

const TILE = 16
const VISION_RADIUS = 7   # 타일 단위
const SOFT_EDGE = 2.5

var _revealed: Dictionary = {}  # Vector2i → bool (한번이라도 본 곳)
var _player: Node = null
var _map_w: int = 0
var _map_h: int = 0

func setup(w: int, h: int) -> void:
	_map_w = w
	_map_h = h
	_revealed.clear()
	queue_redraw()

func _process(_delta: float) -> void:
	if _player == null:
		_player = get_tree().get_first_node_in_group("player")
		return
	_reveal_around(_player.global_position)
	queue_redraw()

func _reveal_around(world_pos: Vector2) -> void:
	var center = Vector2i(int(world_pos.x / TILE), int(world_pos.y / TILE))
	var r = VISION_RADIUS + 1
	for dy in range(-r, r + 1):
		for dx in range(-r, r + 1):
			var dist = Vector2(dx, dy).length()
			if dist <= VISION_RADIUS:
				_revealed[center + Vector2i(dx, dy)] = true

func _draw() -> void:
	if _player == null:
		return
	var center = Vector2i(int(_player.global_position.x / TILE), int(_player.global_position.y / TILE))
	var r = VISION_RADIUS + int(SOFT_EDGE) + 1

	for dy in range(-r, r + 1):
		for dx in range(-r, r + 1):
			var tile = center + Vector2i(dx, dy)
			if tile.x < 0 or tile.y < 0 or tile.x >= _map_w or tile.y >= _map_h:
				continue
			var dist = Vector2(dx, dy).length()
			var alpha: float
			if dist > VISION_RADIUS:
				if _revealed.has(tile):
					alpha = 0.72  # 본 적 있는 곳: 어둡게
				else:
					alpha = 1.0   # 못 본 곳: 완전 어둠
			else:
				# 시야 안: 가장자리 소프트
				var t = clamp((dist - (VISION_RADIUS - SOFT_EDGE)) / SOFT_EDGE, 0.0, 1.0)
				alpha = t * 0.72
			if alpha > 0.01:
				var rect = Rect2(tile.x * TILE, tile.y * TILE, TILE, TILE)
				draw_rect(rect, Color(0, 0, 0, alpha))
