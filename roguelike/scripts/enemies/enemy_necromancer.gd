extends "res://scripts/enemies/enemy_base.gd"

const RAISE_INTERVAL = 6.0

var _raise_timer: float = 3.0

func _ready() -> void:
	max_health = 38
	attack_damage = 9
	move_speed = 38.0
	chase_range = 280.0
	attack_range = 22.0
	attack_cooldown = 2.0
	exp_reward = 30
	body_color = Color(0.2, 0.2, 0.4)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_raise_timer += delta
	if _raise_timer >= RAISE_INTERVAL:
		_raise_timer = 0.0
		_raise_dead()

func _raise_dead() -> void:
	var dungeon = get_tree().get_first_node_in_group("dungeon")
	if dungeon == null:
		return
	var skeleton = CharacterBody2D.new()
	skeleton.set_script(load("res://scripts/enemies/enemy_base.gd"))
	dungeon.register_enemy(skeleton)
	skeleton.global_position = global_position + Vector2(randi_range(-30, 30), randi_range(-30, 30))
	skeleton.modulate = Color(0.7, 0.7, 0.9, 0.8)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 0.3, 0.6))
