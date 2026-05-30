extends "res://scripts/enemies/enemy_base.gd"

var _attack_mode: int = 0

func _ready() -> void:
	max_health = 65
	attack_damage = 18
	move_speed = 65.0
	chase_range = 210.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 40
	body_color = Color(0.7, 0.4, 0.2)
	body_size = 17
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	var dist = global_position.distance_to(_player.global_position)
	if dist < attack_range and _attack_timer <= 0.0:
		_attack_mode = (_attack_mode + 1) % 3
		match _attack_mode:
			0: pass  # Normal attack handled by base
			1:  # Fire breath
				var proj = Node2D.new()
				proj.set_script(load("res://scripts/enemies/projectile.gd"))
				get_parent().add_child(proj)
				proj.global_position = global_position
				proj.setup((_player.global_position - global_position).normalized(), attack_damage, 180.0)
			2:  # Ice slam - slow
				if _player.has_method("get") and _player.get("status") != null:
					_player.status.apply_slow(0.35, 2.0)
