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
const WEAPON_SCRIPTS = [
	"res://scripts/items/weapon_dagger.gd",
	"res://scripts/items/weapon_sword.gd",
	"res://scripts/items/weapon_staff.gd",
]
const TILE_SIZE = 16
const BASE_ENEMIES = 5

# 3층마다 보스 등장
const BOSS_INTERVAL = 3

@onready var tilemap = $TileMapLayer
@onready var player: CharacterBody2D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var generator: Node = $DungeonGenerator
@onready var minimap: Control = $HUD/Minimap
@onready var entities: Node2D = $Entities

var rooms: Array[Rect2i] = []
var enemy_count: int = 0
var is_boss_floor: bool = false

func _ready() -> void:
	var rect = ColorRect.new()
	rect.size = Vector2(12, 12)
	rect.position = Vector2(-6, -6)
	rect.color = Color.DODGER_BLUE
	player.add_child(rect)

	player.health_changed.connect(hud.update_health)
	player.player_died.connect(_on_player_died)
	_generate_floor()

func _generate_floor() -> void:
	for child in entities.get_children():
		child.queue_free()

	rooms = generator.generate(tilemap)
	player.global_position = Vector2(rooms[0].get_center()) * TILE_SIZE
	minimap.setup(rooms)

	is_boss_floor = GameManager.current_floor % BOSS_INTERVAL == 0
	enemy_count = 0

	if is_boss_floor:
		_spawn_boss()
		hud.show_boss_alert()
	else:
		var count = BASE_ENEMIES + GameManager.current_floor - 1
		for i in range(count):
			_spawn_enemy()

	_spawn_items()

func _spawn_enemy() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var script: GDScript = load(ENEMY_SCRIPTS[randi() % ENEMY_SCRIPTS.size()])
	var enemy = _make_enemy(script)
	entities.add_child(enemy)
	enemy.global_position = Vector2(room.get_center()) * TILE_SIZE
	enemy.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _spawn_boss() -> void:
	var boss_pos = Vector2(generator.get_boss_room_center()) * TILE_SIZE
	var boss = _make_enemy(load("res://scripts/enemies/enemy_boss.gd"))
	entities.add_child(boss)
	boss.global_position = boss_pos
	boss.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _make_enemy(script: GDScript) -> CharacterBody2D:
	var enemy = CharacterBody2D.new()
	enemy.set_script(script)
	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 6.0
	col.shape = shape
	enemy.add_child(col)
	return enemy

func _spawn_items() -> void:
	# 일반 아이템
	for i in range(3):
		var room = rooms[randi_range(1, rooms.size() - 1)]
		var script: GDScript = load(ITEM_SCRIPTS[randi() % ITEM_SCRIPTS.size()])
		var item = Area2D.new()
		item.set_script(script)
		entities.add_child(item)
		item.global_position = Vector2(room.get_center()) * TILE_SIZE + Vector2(randi_range(-20, 20), randi_range(-20, 20))

	# 보스 방 또는 5층마다 무기 드롭
	if is_boss_floor or GameManager.current_floor % 5 == 0:
		var room = rooms[randi_range(1, rooms.size() - 1)]
		var script: GDScript = load(WEAPON_SCRIPTS[randi() % WEAPON_SCRIPTS.size()])
		var weapon = Area2D.new()
		weapon.set_script(script)
		entities.add_child(weapon)
		weapon.global_position = Vector2(room.get_center()) * TILE_SIZE

func _on_enemy_died(enemy: Node) -> void:
	GameManager.add_score(enemy.exp_reward)
	hud.update_score(GameManager.score)
	enemy_count -= 1
	if enemy_count <= 0:
		GameManager.next_floor()
		GameManager.save()  # 층 클리어마다 자동 저장
		hud.update_floor(GameManager.current_floor)
		_generate_floor()

func _on_player_died() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")
