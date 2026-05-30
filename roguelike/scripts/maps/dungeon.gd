extends Node2D

const ENEMY_SCRIPTS = [
	"res://scripts/enemies/enemy_base.gd",
	"res://scripts/enemies/enemy_fast.gd",
	"res://scripts/enemies/enemy_tank.gd",
	"res://scripts/enemies/enemy_ranged.gd",
	"res://scripts/enemies/enemy_exploder.gd",
	"res://scripts/enemies/enemy_poison.gd",
	"res://scripts/enemies/enemy_swarm.gd",
	"res://scripts/enemies/enemy_armored.gd",
	"res://scripts/enemies/enemy_ice.gd",
]
const ITEM_SCRIPTS = [
	"res://scripts/items/item_health_potion.gd",
	"res://scripts/items/item_attack_up.gd",
	"res://scripts/items/item_shield.gd",
	"res://scripts/items/item_speed_up.gd",
	"res://scripts/items/item_invincible.gd",
]
const WEAPON_SCRIPTS = [
	"res://scripts/items/weapon_dagger.gd",
	"res://scripts/items/weapon_sword.gd",
	"res://scripts/items/weapon_staff.gd",
	"res://scripts/items/weapon_boomerang.gd",
]
const TILE = 16
const BASE_ENEMIES = 5
const BOSS_INTERVAL = 3

@onready var hud = $HUD
@onready var generator: Node = $DungeonGenerator
@onready var entities: Node2D = $Entities
@onready var map_renderer: Node2D = $MapRenderer
@onready var fog: Node2D = $FogOfWar
@onready var transition: CanvasLayer = $FloorTransition

var player: CharacterBody2D
var camera: Camera2D
var rooms: Array[Rect2i] = []
var enemy_count: int = 0
var is_boss_floor: bool = false

func _ready() -> void:
	add_to_group("dungeon")
	var pause_menu = CanvasLayer.new()
	pause_menu.set_script(load("res://scripts/ui/pause_menu.gd"))
	add_child(pause_menu)
	_spawn_player()
	transition.fade_out()
	_generate_floor()

func _spawn_player() -> void:
	player = CharacterBody2D.new()
	player.set_script(load("res://scripts/player/player.gd"))
	add_child(player)

	camera = Camera2D.new()
	camera.zoom = Vector2(2.5, 2.5)
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 8.0
	player.add_child(camera)

	player.health_changed.connect(hud.update_health)
	player.player_died.connect(_on_player_died)

func _generate_floor() -> void:
	for child in entities.get_children():
		child.queue_free()

	var grid = generator.generate()
	rooms = generator.rooms
	map_renderer.setup(grid, generator.get_map_width(), generator.get_map_height())
	fog.setup(generator.get_map_width(), generator.get_map_height())

	is_boss_floor = GameManager.current_floor % BOSS_INTERVAL == 0
	player.global_position = Vector2(rooms[0].get_center()) * TILE
	hud.minimap.setup(rooms, generator.get_boss_room() if is_boss_floor else Rect2i())
	enemy_count = 0

	var f = GameManager.current_floor
	if f == 6:
		hud.show_theme_enter("Dungeon", Color(0.3, 0.9, 0.4))
	elif f == 11:
		hud.show_theme_enter("Crypt", Color(0.4, 0.6, 1.0))
	elif f == 16:
		hud.show_theme_enter("Hell", Color(1.0, 0.3, 0.1))

	if is_boss_floor:
		_spawn_boss()
		hud.show_boss_alert()
	else:
		for i in range(BASE_ENEMIES + GameManager.current_floor - 1):
			_spawn_enemy()

	_spawn_items()
	_spawn_traps()
	_spawn_secret_loot()
	transition.fade_out()

func _spawn_enemy() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var enemy = _make_enemy(load(ENEMY_SCRIPTS[randi() % ENEMY_SCRIPTS.size()]))
	entities.add_child(enemy)
	enemy.global_position = Vector2(room.get_center()) * TILE
	enemy.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _spawn_boss() -> void:
	var boss = _make_enemy(load("res://scripts/enemies/enemy_boss.gd"))
	entities.add_child(boss)
	boss.global_position = Vector2(generator.get_boss_room().get_center()) * TILE
	boss.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _make_enemy(script: GDScript) -> CharacterBody2D:
	var enemy = CharacterBody2D.new()
	enemy.set_script(script)
	return enemy

func register_enemy(enemy: Node) -> void:
	entities.add_child(enemy)
	enemy.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _spawn_items() -> void:
	for i in range(3):
		var room = rooms[randi_range(1, rooms.size() - 1)]
		_make_item(load(ITEM_SCRIPTS[randi() % ITEM_SCRIPTS.size()]),
			Vector2(room.get_center()) * TILE + Vector2(randi_range(-20, 20), randi_range(-20, 20)))
	if is_boss_floor or GameManager.current_floor % 5 == 0:
		var room = rooms[randi_range(1, rooms.size() - 1)]
		_make_item(load(WEAPON_SCRIPTS[randi() % WEAPON_SCRIPTS.size()]),
			Vector2(room.get_center()) * TILE)

func _spawn_secret_loot() -> void:
	var sr = generator.secret_room
	if sr == Rect2i():
		return
	var center = Vector2(sr.get_center()) * TILE
	for i in range(2):
		_make_item(load(ITEM_SCRIPTS[randi() % ITEM_SCRIPTS.size()]),
			center + Vector2(randi_range(-12, 12), randi_range(-12, 12)))
	if randi() % 3 == 0:
		_make_item(load(WEAPON_SCRIPTS[randi() % WEAPON_SCRIPTS.size()]), center)

func _spawn_traps() -> void:
	var trap_count = 2 + GameManager.current_floor / 2
	for i in range(trap_count):
		var room = rooms[randi_range(1, rooms.size() - 2)]
		var trap = Area2D.new()
		trap.set_script(load("res://scripts/maps/trap_tile.gd"))
		entities.add_child(trap)
		trap.global_position = Vector2(room.get_center()) * TILE + Vector2(randi_range(-24, 24), randi_range(-24, 24))

func _make_item(script: GDScript, pos: Vector2) -> void:
	var item = Area2D.new()
	item.set_script(script)
	entities.add_child(item)
	item.global_position = pos

func _on_enemy_died(enemy: Node) -> void:
	GameManager.add_score(enemy.exp_reward)
	hud.update_score(GameManager.score)
	if randf() < 0.18:
		var drop_pos = enemy.global_position + Vector2(randf_range(-8, 8), randf_range(-8, 8))
		_make_item(load(ITEM_SCRIPTS[randi() % ITEM_SCRIPTS.size()]), drop_pos)
	enemy_count -= 1
	if enemy_count <= 0:
		if player and player.damage_free_time > 5.0:
			var bonus = 50 * GameManager.current_floor
			GameManager.add_score(bonus)
			hud.update_score(GameManager.score)
			hud.show_perfect_bonus(bonus)
		hud.show_floor_clear(GameManager.current_floor)
		GameManager.next_floor()
		GameManager.save()
		hud.update_floor(GameManager.current_floor)
		transition.fade_in(_generate_floor)

func _on_player_died() -> void:
	transition.fade_in(func():
		get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn"))
