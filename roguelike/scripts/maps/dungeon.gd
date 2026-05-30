extends Node2D

@export var enemy_scene: PackedScene
@export var enemies_per_floor: int = 5

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var player: CharacterBody2D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var generator: Node = $DungeonGenerator

var rooms: Array[Rect2i] = []
var enemy_count: int = 0

func _ready() -> void:
	_generate_floor()
	player.health_changed.connect(hud.update_health)
	player.player_died.connect(_on_player_died)

func _generate_floor() -> void:
	rooms = generator.generate(tilemap)

	# 플레이어를 첫 번째 방에 배치
	player.global_position = Vector2(rooms[0].get_center()) * 16

	# 적을 랜덤 방에 배치
	enemy_count = 0
	for i in range(enemies_per_floor):
		_spawn_enemy()

func _spawn_enemy() -> void:
	if enemy_scene == null or rooms.size() < 2:
		return
	var room = rooms[randi_range(1, rooms.size() - 1)]
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = Vector2(room.get_center()) * 16
	enemy.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _on_enemy_died(enemy: Node) -> void:
	GameManager.add_score(enemy.exp_reward)
	enemy_count -= 1
	if enemy_count <= 0:
		GameManager.next_floor()
		_generate_floor()

func _on_player_died() -> void:
	# 게임 오버 씬으로 전환
	get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")
