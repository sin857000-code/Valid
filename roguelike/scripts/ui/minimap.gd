extends Control

# 오른쪽 상단에 미니맵 표시
const TILE_SIZE = 3
const MAP_OFFSET = Vector2(10, 10)

var _rooms: Array[Rect2i] = []
var _player: Node = null

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")

func setup(rooms: Array[Rect2i]) -> void:
	_rooms = rooms
	queue_redraw()

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	# 방 그리기
	for room in _rooms:
		var rect = Rect2(
			MAP_OFFSET + Vector2(room.position) * TILE_SIZE,
			Vector2(room.size) * TILE_SIZE
		)
		draw_rect(rect, Color(0.4, 0.4, 0.4, 0.8))
		draw_rect(rect, Color.WHITE, false)

	# 적 위치
	for enemy in get_tree().get_nodes_in_group("enemy"):
		var etile = enemy.global_position / 16.0
		var epos = MAP_OFFSET + etile * TILE_SIZE
		draw_circle(epos, 2.0, Color(1.0, 0.25, 0.25, 0.9))

	# 플레이어 위치
	if _player:
		var tile_pos = _player.global_position / 16.0
		var dot_pos = MAP_OFFSET + tile_pos * TILE_SIZE
		draw_circle(dot_pos, 3.0, Color.YELLOW)
