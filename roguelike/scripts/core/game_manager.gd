extends Node

# 전역 게임 상태 관리 (Autoload로 등록)
signal player_died
signal floor_cleared
signal game_over

var current_floor: int = 1
var score: int = 0

func next_floor() -> void:
	current_floor += 1
	floor_cleared.emit()

func add_score(amount: int) -> void:
	score += amount

func reset() -> void:
	current_floor = 1
	score = 0
