extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "순간이동 두루마리"
	item_color = Color(0.7, 0.3, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Teleport to a random floor position away from enemies
	var enemies = player.get_tree().get_nodes_in_group("enemy")
	var best_pos = player.global_position
	var best_score = -1.0
	for attempt in range(20):
		var test_pos = player.global_position + Vector2(
			randf_range(-200, 200), randf_range(-200, 200))
		var min_enemy_dist = 9999.0
		for e in enemies:
			min_enemy_dist = min(min_enemy_dist, test_pos.distance_to(e.global_position))
		if min_enemy_dist > best_score:
			best_score = min_enemy_dist
			best_pos = test_pos

	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(player.get_parent(), player.global_position, Color(0.7, 0.3, 1.0))
	player.global_position = best_pos
	hp.spawn(player.get_parent(), best_pos, Color(0.7, 0.3, 1.0))
