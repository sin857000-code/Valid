extends Node

signal player_died
signal floor_cleared
signal level_up(new_level: int)

var current_floor: int = 1
var score: int = 0
var exp: int = 0
var level: int = 1
var kills: int = 0
var floor_time: float = 0.0
var best_floor_time: float = 9999.0

func exp_to_next() -> int:
	return level * 50

func add_exp(amount: int) -> void:
	exp += amount
	while exp >= exp_to_next():
		exp -= exp_to_next()
		level += 1
		level_up.emit(level)

func next_floor() -> void:
	if floor_time < best_floor_time:
		best_floor_time = floor_time
	floor_time = 0.0
	current_floor += 1
	floor_cleared.emit()

func add_score(amount: int) -> void:
	var player = get_tree().get_first_node_in_group("player") if get_tree() else null
	var mult = 1.0
	if player and player.has_meta("exp_mult"):
		mult = player.get_meta("exp_mult")
	score += amount
	kills += 1
	add_exp(int(amount * mult))

func save() -> void:
	var data = {
		"floor": current_floor,
		"score": score,
		"exp": exp,
		"level": level,
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_save() -> bool:
	if not FileAccess.file_exists("user://save.json"):
		return false
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var result = JSON.parse_string(file.get_as_text())
	file.close()
	if result == null:
		return false
	current_floor = result.get("floor", 1)
	score = result.get("score", 0)
	exp = result.get("exp", 0)
	level = result.get("level", 1)
	return true

func has_save() -> bool:
	return FileAccess.file_exists("user://save.json")

func delete_save() -> void:
	if FileAccess.file_exists("user://save.json"):
		DirAccess.remove_absolute("user://save.json")

func _process(delta: float) -> void:
	floor_time += delta

func reset() -> void:
	current_floor = 1
	score = 0
	exp = 0
	level = 1
	kills = 0
	floor_time = 0.0
	best_floor_time = 9999.0
