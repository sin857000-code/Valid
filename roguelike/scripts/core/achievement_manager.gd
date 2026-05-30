extends Node

var achievements: Dictionary = {}

const ACHIEVEMENT_DEFS = [
	{"id": "first_kill", "name": "첫 처치", "desc": "적 1마리 처치"},
	{"id": "kill_100", "name": "백전노장", "desc": "적 100마리 처치"},
	{"id": "floor_10", "name": "탐험가", "desc": "10층 도달"},
	{"id": "floor_20", "name": "영웅", "desc": "20층 도달"},
	{"id": "perfect_floor", "name": "완벽한 전투", "desc": "무피해 층 클리어"},
	{"id": "level_10", "name": "숙련자", "desc": "레벨 10 달성"},
	{"id": "boss_kill", "name": "보스 처치", "desc": "보스 처치"},
]

func _ready() -> void:
	_load()

func check(player: Node) -> void:
	_try_unlock("first_kill", GameManager.kills >= 1)
	_try_unlock("kill_100", GameManager.kills >= 100)
	_try_unlock("floor_10", GameManager.current_floor >= 10)
	_try_unlock("floor_20", GameManager.current_floor >= 20)
	_try_unlock("level_10", GameManager.level >= 10)

func _try_unlock(id: String, condition: bool) -> void:
	if condition and not achievements.get(id, false):
		achievements[id] = true
		_save()
		var hud = get_tree().get_first_node_in_group("hud")
		var def = ACHIEVEMENT_DEFS.filter(func(d): return d.id == id)
		if hud and def.size() > 0:
			hud.show_weapon_pickup("★ 업적: " + def[0].name)

func _save() -> void:
	var f = FileAccess.open("user://achievements.json", FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(achievements))

func _load() -> void:
	if not FileAccess.file_exists("user://achievements.json"):
		return
	var f = FileAccess.open("user://achievements.json", FileAccess.READ)
	if f:
		var result = JSON.parse_string(f.get_as_text())
		if result is Dictionary:
			achievements = result
