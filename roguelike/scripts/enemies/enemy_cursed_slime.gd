extends "res://scripts/enemies/enemy_base.gd"

var _is_small := false

func _ready() -> void:
	if _is_small:
		max_health = 20
		attack_damage = 7
		move_speed = 65.0
		chase_range = 160.0
		attack_range = 14.0
		attack_cooldown = 1.0
		exp_reward = 10
		body_color = Color(0.1, 0.75, 0.3)
		body_size = 9
	else:
		max_health = 48
		attack_damage = 12
		move_speed = 50.0
		chase_range = 180.0
		attack_range = 16.0
		attack_cooldown = 1.1
		exp_reward = 28
		body_color = Color(0.15, 0.85, 0.35)
		body_size = 14
	super._ready()

func take_damage(amount, knockback_dir = Vector2.ZERO) -> void:
	if not _is_small and current_health - amount <= 0:
		_spawn_small_slimes()
	super.take_damage(amount, knockback_dir)

func _spawn_small_slimes() -> void:
	var parent = get_parent()
	if parent == null:
		return
	var offsets = [Vector2(-18, 0), Vector2(18, 0)]
	for offset in offsets:
		var slime = load("res://scripts/enemies/enemy_cursed_slime.gd")
		var new_slime = CharacterBody2D.new()
		new_slime.set_script(slime)
		new_slime.set_meta("is_small_spawn", true)
		parent.add_child(new_slime)
		new_slime.global_position = global_position + offset
		new_slime._is_small = true
		if new_slime.has_method("_ready"):
			pass
