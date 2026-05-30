extends "res://scripts/enemies/enemy_base.gd"

const SUMMON_INTERVAL = 4.0
const MAX_SUMMONS = 4

var _summon_timer: float = 0.0
var _summon_count: int = 0

func _ready() -> void:
	max_health = 35
	attack_damage = 5
	move_speed = 40.0
	chase_range = 220.0
	attack_range = 18.0
	attack_cooldown = 2.0
	exp_reward = 25
	body_color = Color(0.8, 0.2, 0.8)
	body_size = 14
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_summon_timer += delta
	if _summon_timer >= SUMMON_INTERVAL and _summon_count < MAX_SUMMONS:
		_summon_timer = 0.0
		_summon_ghost()

func _summon_ghost() -> void:
	var dungeon = get_tree().get_first_node_in_group("dungeon")
	if dungeon == null:
		return
	var ghost = CharacterBody2D.new()
	ghost.set_script(load("res://scripts/enemies/enemy_fast.gd"))
	dungeon.register_enemy(ghost)
	ghost.global_position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
	ghost.modulate = Color(0.8, 0.5, 1.0, 0.7)
	_summon_count += 1
	ghost.enemy_died.connect(func(e): _summon_count -= 1)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.8, 0.2, 0.8))
