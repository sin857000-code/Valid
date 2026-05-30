extends "res://scripts/enemies/enemy_base.gd"

const VOID_INTERVAL = 5.0

var _void_timer: float = 0.0

func _ready() -> void:
	max_health = 35
	attack_damage = 13
	move_speed = 70.0
	chase_range = 240.0
	attack_range = 19.0
	attack_cooldown = 1.1
	exp_reward = 22
	body_color = Color(0.1, 0.0, 0.2)
	body_size = 11
	super._ready()
	modulate.a = 0.8

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_void_timer += delta
	if _void_timer >= VOID_INTERVAL:
		_void_timer = 0.0
		# Teleport to random location near player
		if _player:
			var offset = Vector2(randi_range(-80, 80), randi_range(-80, 80))
			global_position = _player.global_position + offset
			modulate.a = 0.0
			var t = create_tween()
			t.tween_property(self, "modulate:a", 0.8, 0.3)
