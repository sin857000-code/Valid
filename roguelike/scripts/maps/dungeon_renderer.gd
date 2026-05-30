extends Node2D

const TILE = 16

# Theme palettes indexed by floor range (0=cave, 1=dungeon, 2=crypt, 3=hell)
const THEMES = [
	# cave  (floors 1-5)
	[Color(0.18, 0.16, 0.22), Color(0.20, 0.18, 0.24), Color(0.10, 0.09, 0.13), Color(0.30, 0.27, 0.38)],
	# dungeon  (floors 6-10)
	[Color(0.10, 0.18, 0.12), Color(0.12, 0.20, 0.14), Color(0.06, 0.10, 0.07), Color(0.20, 0.35, 0.22)],
	# crypt  (floors 11-15)
	[Color(0.10, 0.14, 0.22), Color(0.12, 0.16, 0.25), Color(0.06, 0.08, 0.14), Color(0.20, 0.28, 0.42)],
	# hell  (floors 16+)
	[Color(0.22, 0.10, 0.08), Color(0.24, 0.12, 0.09), Color(0.12, 0.05, 0.04), Color(0.42, 0.18, 0.12)],
]

var _grid: Array = []
var _w: int = 0
var _h: int = 0
var _theme: Array = THEMES[0]

func setup(grid: Array, w: int, h: int) -> void:
	_grid = grid
	_w = w
	_h = h
	var floor_num = GameManager.current_floor
	if floor_num >= 16:
		_theme = THEMES[3]
	elif floor_num >= 11:
		_theme = THEMES[2]
	elif floor_num >= 6:
		_theme = THEMES[1]
	else:
		_theme = THEMES[0]
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
				draw_rect(rect, _theme[1] if alt else _theme[0])
			else:         # wall
				draw_rect(rect, _theme[2])
				if y + 1 < _h and _grid[y + 1][x] == 1:
					draw_rect(Rect2(x * TILE, y * TILE + TILE - 3, TILE, 3), _theme[3])

func world_to_tile(world_pos: Vector2) -> Vector2i:
	return Vector2i(int(world_pos.x / TILE), int(world_pos.y / TILE))

func is_floor(tx: int, ty: int) -> bool:
	if tx < 0 or ty < 0 or tx >= _w or ty >= _h:
		return false
	return _grid[ty][tx] == 1
