extends "res://scripts/enemies/enemy_base.gd"

const SHIELD_HP = 20
var _shield_current: int = 0
var _shield_visual: ColorRect

func _ready() -> void:
	max_health = 40
	attack_damage = 10
	move_speed = 55.0
	chase_range = 200.0
	attack_range = 20.0
	attack_cooldown = 1.3
	exp_reward = 22
	body_color = Color(0.3, 0.5, 0.9)
	body_size = 13
	super._ready()
	_shield_current = SHIELD_HP
	_spawn_shield_visual()

func _spawn_shield_visual() -> void:
	_shield_visual = ColorRect.new()
	_shield_visual.size = Vector2(body_size * 2 + 8, body_size * 2 + 8)
	_shield_visual.position = Vector2(-(body_size + 4), -(body_size + 4))
	_shield_visual.color = Color(0.4, 0.6, 1.0, 0.4)
	add_child(_shield_visual)

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	if _shield_current > 0:
		_shield_current -= amount
		if _shield_current <= 0:
			_shield_current = 0
			if _shield_visual:
				_shield_visual.queue_free()
				_shield_visual = null
		var hp = load("res://scripts/ui/hit_particle.gd")
		hp.spawn(get_parent(), global_position, Color(0.4, 0.6, 1.0))
		return
	super.take_damage(amount, source_pos)
