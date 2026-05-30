extends "res://scripts/enemies/enemy_base.gd"

var _cast_timer = 0.0

func _ready() -> void:
	max_health = 30
	attack_damage = 15
	move_speed = 40.0
	chase_range = 220.0
	attack_range = 30.0
	attack_cooldown = 99.0
	exp_reward = 26
	body_color = Color(0.95, 0.95, 0.7)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_cast_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < 200.0 and _cast_timer <= 0.0:
		_cast_timer = 2.5
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		proj.global_position = global_position
		proj.setup((_player.global_position - global_position).normalized(), attack_damage, 170.0)
