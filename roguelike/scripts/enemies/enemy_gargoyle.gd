extends "res://scripts/enemies/enemy_base.gd"

var _stone_form: bool = true
var _stone_timer: float = 3.0

func _ready() -> void:
	max_health = 50
	attack_damage = 16
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 20.0
	attack_cooldown = 1.2
	exp_reward = 28
	body_color = Color(0.5, 0.5, 0.5)
	body_size = 14
	super._ready()
	modulate = Color(0.7, 0.7, 0.7)

func _physics_process(delta: float) -> void:
	if _stone_form:
		_stone_timer -= delta
		if _stone_timer <= 0.0:
			_stone_form = false
			modulate = Color.WHITE
		return
	super._physics_process(delta)

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	if _stone_form:
		return
	super.take_damage(amount, source_pos)
