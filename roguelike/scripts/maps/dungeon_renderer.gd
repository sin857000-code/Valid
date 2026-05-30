extends Node2D

# TileMapLayer 대신 직접 그리는 맵 렌더러
const TILE = 16
const COLOR_FLOOR      = Color(0.18, 0.16, 0.22)
const COLOR_FLOOR_ALT  = Color(0.20, 0.18, 0.24)
const COLOR_WALL       = Color(0.10, 0.09, 0.13)
const COLOR_WALL_TOP   = Color(0.30, 0.27, 0.38)
const COLOR_BORDER     = Color(0.08, 0.07, 0.10)

var _grid: Array = []   # 2D array of ints  0=wall 1=floor
var _w: int = 0
var _h: int = 0

func setup(grid: Array, w: int, h: int) -> void:
	_grid = grid
	_w = w
	_h = h
	queue_redraw()

func _draw() -> void:
	if _grid.is_empty():
		return
	for y in range(_h):
		for x in range(_w):
			var val = _grid[y][x]
			var rect = Rect2(x * TILE, y * TILE, TILE, TILE)
			if val == 1:  # floor
				var alt = (x + y) % 2 == 0
				draw_rect(rect, COLOR_FLOOR_ALT if alt else COLOR_FLOOR)
			else:         # wall
				draw_rect(rect, COLOR_WALL)
				# 윗면 하이라이트 (벽 입체감)
				if y + 1 < _h and _grid[y + 1][x] == 1:
					draw_rect(Rect2(x * TILE, y * TILE + TILE - 3, TILE, 3), COLOR_WALL_TOP)

func world_to_tile(world_pos: Vector2) -> Vector2i:
	return Vector2i(int(world_pos.x / TILE), int(world_pos.y / TILE))

func is_floor(tx: int, ty: int) -> bool:
	if tx < 0 or ty < 0 or tx >= _w or ty >= _h:
		return false
	return _grid[ty][tx] == 1
