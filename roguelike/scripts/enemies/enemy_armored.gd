extends "res://scripts/enemies/enemy_base.gd"

var _shield_active: bool = true
var _shield_visual: ColorRect

func _ready() -> void:
	max_health = 50
	move_speed = 40.0
	attack_damage = 12
	attack_range = 20.0
	exp_reward = 25
	body_color = Color(0.5, 0.5, 0.7)
	body_size = 16
	super._ready()
	_add_shield_visual()

func _add_shield_visual() -> void:
	_shield_visual = ColorRect.new()
	_shield_visual.size = Vector2(24, 24)
	_shield_visual.position = Vector2(-12, -12)
	_shield_visual.color = Color(0.5, 0.8, 1.0, 0.4)
	add_child(_shield_visual)
	var pulse = _shield_visual.create_tween().set_loops()
	pulse.tween_property(_shield_visual, "modulate:a", 0.8, 0.5)
	pulse.tween_property(_shield_visual, "modulate:a", 0.3, 0.5)

func take_damage(amount: int, source_pos: Vector2 = Vector2.ZERO) -> void:
	if _shield_active:
		_shield_active = false
		_shield_visual.queue_free()
		_shield_visual = null
		var hp = load("res://scripts/ui/hit_particle.gd")
		hp.spawn(get_parent(), global_position, Color(0.5, 0.8, 1.0))
		var dn = load("res://scripts/ui/damage_number.gd")
		dn.spawn(get_parent(), global_position, 0)
		return
	super.take_damage(amount, source_pos)
