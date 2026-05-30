extends "res://scripts/enemies/enemy_base.gd"

var _is_split: bool = false

func _ready() -> void:
	if _is_split:
		max_health = 8
		move_speed = 110.0
		attack_damage = 2
		exp_reward = 4
		body_color = Color(0.9, 0.75, 0.2)
		body_size = 8
	else:
		max_health = 20
		move_speed = 90.0
		attack_damage = 4
		exp_reward = 8
		body_color = Color(0.8, 0.6, 0.1)
		body_size = 14
	super._ready()

func take_damage(amount: int, source_pos: Vector2 = Vector2.ZERO) -> void:
	if _dying:
		return
	current_health -= amount
	current_health = max(current_health, 0)
	_visual.update_hp(float(current_health) / float(max_health))
	_visual.flash_hit()

	if source_pos != Vector2.ZERO:
		var kb_dir = (global_position - source_pos).normalized()
		velocity += kb_dir * 180.0

	var dn = load("res://scripts/ui/damage_number.gd")
	dn.spawn(get_parent(), global_position, amount)

	if current_health == 0:
		_dying = true
		set_physics_process(false)
		if not _is_split:
			_spawn_splits()
		_visual.death_anim(func(): enemy_died.emit(self); queue_free())

func _spawn_splits() -> void:
	var dungeon = get_tree().get_first_node_in_group("dungeon")
	if dungeon == null:
		return
	for i in range(2):
		var mini = CharacterBody2D.new()
		mini.set_script(load("res://scripts/enemies/enemy_swarm.gd"))
		mini._is_split = true
		dungeon.register_enemy(mini)
		mini.global_position = global_position + Vector2(randf_range(-14, 14), randf_range(-14, 14))
