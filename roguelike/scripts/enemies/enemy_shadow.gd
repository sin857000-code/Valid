extends "res://scripts/enemies/enemy_base.gd"

const CLONE_INTERVAL = 6.0

var _clone_timer: float = 0.0
var _is_clone: bool = false

func _ready() -> void:
	max_health = 25
	attack_damage = 10
	move_speed = 80.0
	chase_range = 260.0
	attack_range = 17.0
	attack_cooldown = 1.0
	exp_reward = 18
	body_color = Color(0.15, 0.1, 0.2)
	body_size = 11
	super._ready()
	modulate.a = 0.5

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _is_clone:
		return
	_clone_timer += delta
	if _clone_timer >= CLONE_INTERVAL:
		_clone_timer = 0.0
		_spawn_shadow_clone()

func _spawn_shadow_clone() -> void:
	var clone = CharacterBody2D.new()
	clone.set_script(load("res://scripts/enemies/enemy_shadow.gd"))
	get_parent().add_child(clone)
	clone.global_position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
	clone._is_clone = true
	clone.max_health = 8
	clone.current_health = 8
	clone.exp_reward = 0
