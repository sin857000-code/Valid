extends "res://scripts/items/weapon_base.gd"

const CHAIN_TARGETS = 2
const CHAIN_JUMP_RANGE = 120.0

func _ready() -> void:
	weapon_name = "Thunder Staff"
	attack_damage = 22
	attack_range = 180.0
	attack_cooldown = 1.2
	weapon_color = Color(0.6, 0.7, 1.0)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	var all_enemies = player.get_tree().get_nodes_in_group("enemies")
	var in_range = []
	for body in all_enemies:
		if player.global_position.distance_to(body.global_position) <= attack_range:
			in_range.append(body)
	in_range.sort_custom(func(a, b):
		return player.global_position.distance_to(a.global_position) < player.global_position.distance_to(b.global_position)
	)

	var hit = []
	for body in in_range:
		if hit.size() >= CHAIN_TARGETS:
			break
		hit.append(body)

	var last_pos = player.global_position
	for body in hit:
		if body.has_method("take_damage"):
			body.take_damage(atk, (body.global_position - last_pos).normalized())
		_spawn_lightning_visual(last_pos, body.global_position, player)
		last_pos = body.global_position

func _spawn_lightning_visual(from: Vector2, to: Vector2, player) -> void:
	var line = Line2D.new()
	line.add_point(from)
	line.add_point(to)
	line.width = 2.0
	line.default_color = Color(0.7, 0.85, 1.0, 0.9)
	player.get_parent().add_child(line)
	var t = Timer.new()
	t.wait_time = 0.12
	t.one_shot = true
	line.add_child(t)
	t.timeout.connect(line.queue_free)
	t.start()
