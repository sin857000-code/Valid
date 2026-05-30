extends Node

const SAVE_PATH = "user://highscore.json"
const MAX_ENTRIES = 5

static func load_scores() -> Array:
	if not FileAccess.file_exists(SAVE_PATH):
		return []
	var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(f.get_as_text())
	f.close()
	return data if data is Array else []

static func save_score(score: int, floor_reached: int, level: int) -> void:
	var scores = load_scores()
	scores.append({
		"score": score,
		"floor": floor_reached,
		"level": level,
		"date": Time.get_date_string_from_system()
	})
	scores.sort_custom(func(a, b): return a["score"] > b["score"])
	if scores.size() > MAX_ENTRIES:
		scores = scores.slice(0, MAX_ENTRIES)
	var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(scores))
	f.close()

static func get_best_score() -> int:
	var scores = load_scores()
	if scores.is_empty():
		return 0
	return scores[0]["score"]

static func get_scores() -> Array:
	return load_scores()
