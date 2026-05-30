extends Node

# BSP(Binary Space Partitioning) 기반 절차적 맵 생성

const TILE_FLOOR = 0
const TILE_WALL = 1

const MAP_WIDTH = 50
const MAP_HEIGHT = 40
const MIN_ROOM_SIZE = 5
const MAX_ROOM_SIZE = 12

var tile_map: TileMapLayer
var rooms: Array[Rect2i] = []

func generate(tilemap: TileMapLayer) -> Array[Rect2i]:
	tile_map = tilemap
	rooms.clear()
	_fill_walls()
	_bsp_split(Rect2i(1, 1, MAP_WIDTH - 2, MAP_HEIGHT - 2), 4)
	_connect_rooms()
	return rooms

func _fill_walls() -> void:
	for x in range(MAP_WIDTH):
		for y in range(MAP_HEIGHT):
			tile_map.set_cell(Vector2i(x, y), 0, Vector2i(TILE_WALL, 0))

func _bsp_split(area: Rect2i, depth: int) -> void:
	if depth == 0 or area.size.x < MIN_ROOM_SIZE * 2 or area.size.y < MIN_ROOM_SIZE * 2:
		_carve_room(area)
		return

	var split_horizontal = bool(randi() % 2)
	if area.size.x > area.size.y:
		split_horizontal = false
	elif area.size.y > area.size.x:
		split_horizontal = true

	if split_horizontal:
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
			tile_map.set_cell(Vector2i(rx, ry), 0, Vector2i(TILE_FLOOR, 0))

	rooms.append(room)

func _connect_rooms() -> void:
	for i in range(rooms.size() - 1):
		var a = rooms[i].get_center()
		var b = rooms[i + 1].get_center()
		_carve_corridor(a, b)

func _carve_corridor(from: Vector2i, to: Vector2i) -> void:
	var x = from.x
	while x != to.x:
		tile_map.set_cell(Vector2i(x, from.y), 0, Vector2i(TILE_FLOOR, 0))
		x += sign(to.x - x)
	var y = from.y
	while y != to.y:
		tile_map.set_cell(Vector2i(to.x, y), 0, Vector2i(TILE_FLOOR, 0))
		y += sign(to.y - y)

func get_random_room_center() -> Vector2i:
	return rooms[randi() % rooms.size()].get_center()

func get_boss_room_center() -> Vector2i:
	# 가장 마지막 방을 보스 방으로 사용
	return rooms[rooms.size() - 1].get_center()

func get_boss_room() -> Rect2i:
	return rooms[rooms.size() - 1]
