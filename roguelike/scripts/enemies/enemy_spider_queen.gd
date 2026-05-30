extends "res://scripts/enemies/enemy_base.gd"

var _spawn_timer = 0.0

func _ready() -> void:
	max_health = 80
	attack_damage = 20
	move_speed = 55.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.2
	exp_reward = 50
	body_color = Color(0.3, 0.1, 0.3)
	body_size = 18
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_spawn_timer -= delta
	if _spawn_timer <= 0.0:
		_spawn_timer = 5.0
		for i in 2:
			var s = CharacterBody2D.new()
			s.set_script(load("res://scripts/enemies/enemy_spider.gd"))
			get_parent().add_child(s)
			s.global_position = global_position + Vector2(randf_range(-30, 30), randf_range(-30, 30))
