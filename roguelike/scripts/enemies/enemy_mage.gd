extends "res://scripts/enemies/enemy_base.gd"

var _cast_timer = 0.0

func _ready() -> void:
	max_health = 35
	attack_damage = 16
	move_speed = 45.0
	chase_range = 220.0
	attack_range = 30.0
	attack_cooldown = 1.5
	exp_reward = 28
	body_color = Color(0.4, 0.2, 0.8)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_cast_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < 200.0 and _cast_timer <= 0.0:
		_cast_timer = 3.0
		for i in 3:
			var proj = Node2D.new()
			proj.set_script(load("res://scripts/enemies/projectile.gd"))
			get_parent().add_child(proj)
			proj.global_position = global_position
			var angle = (_player.global_position - global_position).angle() + (i - 1) * 0.3
			proj.setup(Vector2.from_angle(angle), attack_damage, 160.0)
