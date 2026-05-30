extends Node2D

const ENEMY_SCRIPTS = [
	"res://scripts/enemies/enemy_base.gd",
	"res://scripts/enemies/enemy_fast.gd",
	"res://scripts/enemies/enemy_tank.gd",
]
const ITEM_SCRIPTS = [
	"res://scripts/items/item_health_potion.gd",
	"res://scripts/items/item_attack_up.gd",
]
const TILE_SIZE = 16
const ENEMIES_PER_FLOOR = 5
const ITEMS_PER_FLOOR = 3

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var player: CharacterBody2D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var generator: Node = $DungeonGenerator
@onready var minimap: Control = $HUD/Minimap
@onready var entities: Node2D = $Entities

var rooms: Array[Rect2i] = []
var enemy_count: int = 0

func _ready() -> void:
	# 플레이어 스프라이트 코드로 생성
	var rect = ColorRect.new()
	rect.size = Vector2(12, 12)
	rect.position = Vector2(-6, -6)
	rect.color = Color.DODGER_BLUE
	player.add_child(rect)

	player.health_changed.connect(hud.update_health)
	player.player_died.connect(_on_player_died)
	_generate_floor()

func _generate_floor() -> void:
	# 이전 엔티티 정리
	for child in entities.get_children():
		child.queue_free()

	rooms = generator.generate(tilemap)
	player.global_position = Vector2(rooms[0].get_center()) * TILE_SIZE
	minimap.setup(rooms)

	enemy_count = 0
	for i in range(ENEMIES_PER_FLOOR + GameManager.current_floor - 1):
		_spawn_enemy()

	for i in range(ITEMS_PER_FLOOR):
		_spawn_item()

func _spawn_enemy() -> void:
	var room = rooms[randi_range(1, rooms.size() - 1)]
	var script: GDScript = load(ENEMY_SCRIPTS[randi() % ENEMY_SCRIPTS.size()])
	var enemy = CharacterBody2D.new()
	enemy.set_script(script)

	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 6.0
	col.shape = shape
	enemy.add_child(col)

	entities.add_child(enemy)
	enemy.global_position = Vector2(room.get_center()) * TILE_SIZE
	enemy.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _spawn_item() -> void:
	var room = rooms[randi_range(1, rooms.size() - 1)]
	var script: GDScript = load(ITEM_SCRIPTS[randi() % ITEM_SCRIPTS.size()])
	var item = Area2D.new()
	item.set_script(script)
	entities.add_child(item)
	item.global_position = Vector2(room.get_center()) * TILE_SIZE + Vector2(randi_range(-20, 20), randi_range(-20, 20))

func _on_enemy_died(enemy: Node) -> void:
	GameManager.add_score(enemy.exp_reward)
	hud.update_score(GameManager.score)
	enemy_count -= 1
	if enemy_count <= 0:
		GameManager.next_floor()
		hud.update_floor(GameManager.current_floor)
		_generate_floor()

func _on_player_died() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")
