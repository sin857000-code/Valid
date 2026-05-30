extends "res://scripts/enemies/enemy_base.gd"

var _disguised: bool = true
var _disguise_rect: ColorRect

func _ready() -> void:
	max_health = 35
	attack_damage = 14
	move_speed = 80.0
	chase_range = 50.0
	attack_range = 18.0
	attack_cooldown = 0.8
	exp_reward = 25
	body_color = Color(0.8, 0.7, 0.2)
	body_size = 11
	super._ready()
	_spawn_disguise()

func _spawn_disguise() -> void:
	_disguise_rect = ColorRect.new()
	_disguise_rect.size = Vector2(20, 20)
	_disguise_rect.position = Vector2(-10, -10)
	_disguise_rect.color = Color(0.8, 0.6, 0.1)
	add_child(_disguise_rect)
	modulate.a = 0.0

func _physics_process(delta: float) -> void:
	if _dying:
		return
	if _disguised and _player != null:
		var dist = global_position.distance_to(_player.global_position)
		if dist < chase_range:
			_reveal()
	if not _disguised:
		super._physics_process(delta)

func _reveal() -> void:
	_disguised = false
	if _disguise_rect:
		_disguise_rect.queue_free()
	modulate.a = 1.0
	chase_range = 200.0
