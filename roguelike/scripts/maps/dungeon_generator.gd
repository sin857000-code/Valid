extends Node

const TILE_FLOOR = 1
const TILE_WALL  = 0

const MAP_WIDTH   = 60
const MAP_HEIGHT  = 50
const MIN_ROOM_SIZE = 5
const MAX_ROOM_SIZE = 13

var rooms: Array[Rect2i] = []
var _grid: Array = []

func generate() -> Array:
	rooms.clear()
	_grid = []
	for y in range(MAP_HEIGHT):
		_grid.append([])
		for x in range(MAP_WIDTH):
			_grid[y].append(TILE_WALL)

	_bsp_split(Rect2i(1, 1, MAP_WIDTH - 2, MAP_HEIGHT - 2), 5)
	_connect_rooms()
	return _grid

func _bsp_split(area: Rect2i, depth: int) -> void:
	if depth == 0 or area.size.x < MIN_ROOM_SIZE * 2 or area.size.y < MIN_ROOM_SIZE * 2:
		_carve_room(area)
		return

	var horiz = bool(randi() % 2)
	if area.size.x > area.size.y * 1.3:
		horiz = false
	elif area.size.y > area.size.x * 1.3:
		horiz = true

	if horiz:
		var split = randi_range(MIN_ROOM_SIZE, area.size.y - MIN_ROOM_SIZE)
		_bsp_split(Rect2i(area.position, Vector2i(area.size.x, split)), depth - 1)
		_bsp_split(Rect2i(area.position + Vector2i(0, split), Vector2i(area.size.x, area.size.y - split)), depth - 1)
	else:
		var split = randi_range(MIN_ROOM_SIZE, area.size.x - MIN_ROOM_SIZE)
		_bsp_split(Rect2i(area.position, Vector2i(split, area.size.y)), depth - 1)
		_bsp_split(Rect2i(area.position + Vector2i(split, 0), Vector2i(area.size.x - split, area.size.y)), depth - 1)

func _carve_room(area: Rect2i) -> void:
	var w = randi_range(MIN_ROOM_SIZE, min(MAX_ROOM_SIZE, area.size.x - 1))
	var h = randi_range(MIN_ROOM_SIZE, min(MAX_ROOM_SIZE, area.size.y - 1))
	var x = area.position.x + randi_range(0, area.size.x - w)
	var y = area.position.y + randi_range(0, area.size.y - h)
	var room = Rect2i(x, y, w, h)
	for rx in range(room.position.x, room.position.x + room.size.x):
		for ry in range(room.position.y, room.position.y + room.size.y):
			_grid[ry][rx] = TILE_FLOOR
	rooms.append(room)

func _connect_rooms() -> void:
	for i in range(rooms.size() - 1):
		var a = rooms[i].get_center()
		var b = rooms[i + 1].get_center()
		_carve_corridor(a, b)

func _carve_corridor(from: Vector2i, to: Vector2i) -> void:
	var x = from.x
	while x != to.x:
		_grid[from.y][x] = TILE_FLOOR
		x += sign(to.x - x)
	var y = from.y
	while y != to.y:
		_grid[y][to.x] = TILE_FLOOR
		y += sign(to.y - y)

func get_boss_room() -> Rect2i:
	return rooms[rooms.size() - 1]

func get_map_width() -> int:
	return MAP_WIDTH

func get_map_height() -> int:
	return MAP_HEIGHT
