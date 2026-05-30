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
	"res://scripts/enemies/enemy_teleporter.gd",
	"res://scripts/enemies/enemy_mirror.gd",
	"res://scripts/enemies/enemy_healer.gd",
	"res://scripts/enemies/enemy_giant.gd",
	"res://scripts/enemies/enemy_summoner.gd",
	"res://scripts/enemies/enemy_shield.gd",
	"res://scripts/enemies/enemy_phantom.gd",
	"res://scripts/enemies/enemy_regenerator.gd",
	"res://scripts/enemies/enemy_charger.gd",
	"res://scripts/enemies/enemy_ninja.gd",
	"res://scripts/enemies/enemy_vampire_bat.gd",
	"res://scripts/enemies/enemy_golem.gd",
	"res://scripts/enemies/enemy_ghost.gd",
	"res://scripts/enemies/enemy_spider.gd",
	"res://scripts/enemies/enemy_bomber.gd",
	"res://scripts/enemies/enemy_serpent.gd",
	"res://scripts/enemies/enemy_wisp.gd",
	"res://scripts/enemies/enemy_berserker.gd",
	"res://scripts/enemies/enemy_witch.gd",
	"res://scripts/enemies/enemy_necromancer.gd",
	"res://scripts/enemies/enemy_lava_elemental.gd",
	"res://scripts/enemies/enemy_ice_golem.gd",
	"res://scripts/enemies/enemy_dragon.gd",
	"res://scripts/enemies/enemy_titan.gd",
	"res://scripts/enemies/enemy_shadow.gd",
	"res://scripts/enemies/enemy_elemental.gd",
	"res://scripts/enemies/enemy_mimic.gd",
	"res://scripts/enemies/enemy_sentinel.gd",
	"res://scripts/enemies/enemy_cursed_knight.gd",
	"res://scripts/enemies/enemy_plague_doctor.gd",
	"res://scripts/enemies/enemy_revenant.gd",
	"res://scripts/enemies/enemy_crystal.gd",
	"res://scripts/enemies/enemy_void_walker.gd",
]
const ITEM_SCRIPTS = [
	"res://scripts/items/item_health_potion.gd",
	"res://scripts/items/item_attack_up.gd",
	"res://scripts/items/item_shield.gd",
	"res://scripts/items/item_speed_up.gd",
	"res://scripts/items/item_invincible.gd",
	"res://scripts/items/item_rage.gd",
	"res://scripts/items/item_regen.gd",
	"res://scripts/items/item_lifesteal.gd",
	"res://scripts/items/item_teleport.gd",
	"res://scripts/items/item_exp_boost.gd",
	"res://scripts/items/item_berserker.gd",
	"res://scripts/items/item_iron_boots.gd",
	"res://scripts/items/item_double_exp.gd",
	"res://scripts/items/item_magnet.gd",
	"res://scripts/items/item_second_chance.gd",
	"res://scripts/items/item_vampire.gd",
	"res://scripts/items/item_thorns.gd",
	"res://scripts/items/item_cooldown_reduction.gd",
	"res://scripts/items/item_lucky.gd",
	"res://scripts/items/item_time_slow.gd",
	"res://scripts/items/item_explosive_shots.gd",
	"res://scripts/items/item_power_surge.gd",
	"res://scripts/items/item_adrenaline.gd",
	"res://scripts/items/item_dash_attack.gd",
	"res://scripts/items/item_barrier.gd",
	"res://scripts/items/item_gold_rush.gd",
	"res://scripts/items/item_clone.gd",
	"res://scripts/items/item_mirror_shield.gd",
]
const WEAPON_SCRIPTS = [
	"res://scripts/items/weapon_dagger.gd",
	"res://scripts/items/weapon_sword.gd",
	"res://scripts/items/weapon_staff.gd",
	"res://scripts/items/weapon_boomerang.gd",
	"res://scripts/items/weapon_shotgun.gd",
	"res://scripts/items/weapon_wand.gd",
	"res://scripts/items/weapon_freeze.gd",
	"res://scripts/items/weapon_lightning.gd",
	"res://scripts/items/weapon_cannon.gd",
	"res://scripts/items/weapon_axe.gd",
	"res://scripts/items/weapon_scythe.gd",
	"res://scripts/items/weapon_hammer.gd",
	"res://scripts/items/weapon_spear.gd",
	"res://scripts/items/weapon_crossbow.gd",
	"res://scripts/items/weapon_trident.gd",
	"res://scripts/items/weapon_flail.gd",
	"res://scripts/items/weapon_holy_sword.gd",
	"res://scripts/items/weapon_dark_blade.gd",
	"res://scripts/items/weapon_soul_staff.gd",
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
	var stat_choice = CanvasLayer.new()
	stat_choice.set_script(load("res://scripts/ui/stat_choice.gd"))
	add_child(stat_choice)
	var achiev = Node.new()
	achiev.set_script(load("res://scripts/core/achievement_manager.gd"))
	achiev.name = "AchievementManager"
	add_child(achiev)
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

	_floor_entry_zoom()

	if is_boss_floor:
		_spawn_boss()
		hud.show_boss_alert()
	else:
		for i in range(BASE_ENEMIES + GameManager.current_floor - 1):
			_spawn_enemy()
		if GameManager.current_floor % 5 == 0 and not is_boss_floor:
			_spawn_elite()

	_spawn_items()
	_spawn_traps()
	_spawn_secret_loot()
	_spawn_chests()
	if GameManager.current_floor >= 16:
		_spawn_lava_tiles()
	if GameManager.current_floor % 4 == 2 and not is_boss_floor:
		_spawn_shop()
	if GameManager.current_floor % 3 == 0 and not is_boss_floor:
		_spawn_healing_fountain()
	if GameManager.current_floor > 2 and randi() % 3 == 0:
		_spawn_floor_event()
	transition.fade_out()

func _spawn_enemy() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var enemy = _make_enemy(load(ENEMY_SCRIPTS[randi() % ENEMY_SCRIPTS.size()]))
	entities.add_child(enemy)
	# Floor scaling: +8% HP and +5% damage per floor beyond 1
	var scale_factor = 1.0 + (GameManager.current_floor - 1) * 0.08
	enemy.max_health = int(enemy.max_health * scale_factor)
	enemy.current_health = enemy.max_health
	enemy.attack_damage = max(1, int(enemy.attack_damage * (1.0 + (GameManager.current_floor - 1) * 0.05)))
	enemy.global_position = Vector2(room.get_center()) * TILE
	enemy.enemy_died.connect(_on_enemy_died)
	enemy_count += 1

func _spawn_elite() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var elite = _make_enemy(load(ENEMY_SCRIPTS[randi_range(1, ENEMY_SCRIPTS.size() - 1)]))
	entities.add_child(elite)
	elite.max_health = int(elite.max_health * 3.0)
	elite.current_health = elite.max_health
	elite.attack_damage = int(elite.attack_damage * 1.5)
	elite.exp_reward = int(elite.exp_reward * 3)
	elite.modulate = Color(1.0, 0.6, 0.0)  # golden tint
	elite.global_position = Vector2(room.get_center()) * TILE
	elite.enemy_died.connect(_on_enemy_died)
	enemy_count += 1
	hud.show_weapon_pickup("⚡ ELITE ENEMY!")

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

func _floor_entry_zoom() -> void:
	if camera == null:
		return
	var target_zoom = Vector2(2.5, 2.5)
	camera.zoom = Vector2(4.0, 4.0)
	var tween = camera.create_tween()
	tween.tween_property(camera, "zoom", target_zoom, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _spawn_clear_burst() -> void:
	if player == null:
		return
	var hp = load("res://scripts/ui/hit_particle.gd")
	for i in range(3):
		hp.spawn(entities, player.global_position, Color(randf(), randf_range(0.7, 1.0), randf_range(0.2, 0.6)))

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

func _spawn_chests() -> void:
	var chest_count = 1 + (1 if GameManager.current_floor % 4 == 0 else 0)
	for i in range(chest_count):
		var room = rooms[randi_range(1, rooms.size() - 2)]
		var chest = Area2D.new()
		chest.set_script(load("res://scripts/maps/chest.gd"))
		entities.add_child(chest)
		chest.global_position = Vector2(room.get_center()) * TILE + Vector2(randi_range(-16, 16), randi_range(-16, 16))

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

func _spawn_floor_event() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var event = Node2D.new()
	event.set_script(load("res://scripts/maps/floor_event.gd"))
	entities.add_child(event)
	event.setup(Vector2(room.get_center()) * TILE)

func _spawn_healing_fountain() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var fountain = Area2D.new()
	fountain.set_script(load("res://scripts/maps/healing_fountain.gd"))
	entities.add_child(fountain)
	fountain.global_position = Vector2(room.get_center()) * TILE

func _spawn_shop() -> void:
	var room = rooms[randi_range(1, rooms.size() - 2)]
	var shop = Node2D.new()
	shop.set_script(load("res://scripts/maps/shop_room.gd"))
	entities.add_child(shop)
	shop.setup(Vector2(room.get_center()) * TILE)

func _spawn_lava_tiles() -> void:
	var count = 4 + (GameManager.current_floor - 16) / 2
	for i in range(count):
		var room = rooms[randi_range(1, rooms.size() - 2)]
		var lava = Area2D.new()
		lava.set_script(load("res://scripts/maps/lava_tile.gd"))
		entities.add_child(lava)
		lava.global_position = Vector2(room.get_center()) * TILE + Vector2(randi_range(-24, 24), randi_range(-24, 24))

func _make_item(script: GDScript, pos: Vector2) -> void:
	var item = Area2D.new()
	item.set_script(script)
	entities.add_child(item)
	item.global_position = pos

func _on_enemy_died(enemy: Node) -> void:
	var achiev = get_node_or_null("AchievementManager")
	if achiev:
		achiev.check(player)
	GameManager.add_score(enemy.exp_reward)
	hud.update_score(GameManager.score)
	if randf() < 0.18:
		var drop_pos = enemy.global_position + Vector2(randf_range(-8, 8), randf_range(-8, 8))
		_make_item(load(ITEM_SCRIPTS[randi() % ITEM_SCRIPTS.size()]), drop_pos)
	enemy_count -= 1
	if enemy_count <= 0:
		_spawn_clear_burst()
		if player and player.damage_free_time > 5.0:
			var bonus = 50 * GameManager.current_floor
			GameManager.add_score(bonus)
			hud.update_score(GameManager.score)
			hud.show_perfect_bonus(bonus)
		hud.show_floor_clear(GameManager.current_floor)
		var achiev = get_node_or_null("AchievementManager")
		if achiev:
			achiev.check(player)
		GameManager.next_floor()
		GameManager.save()
		hud.update_floor(GameManager.current_floor)
		transition.fade_in(_generate_floor)

func _on_player_died() -> void:
	transition.fade_in(func():
		get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn"))
