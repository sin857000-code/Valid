extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Frost Bow"
	attack_damage = 18
	attack_range = 200.0
	attack_cooldown = 1.1
	weapon_color = Color(0.5, 0.8, 1.0)
	super._ready()

func _do_attack(player) -> void:
	var atk = attack_damage * (player.get_meta("attack_mult") if player.has_meta("attack_mult") else 1.0)
	var nearest = null
	var best = attack_range
	for body in player.get_tree().get_nodes_in_group("enemies"):
		var d = player.global_position.distance_to(body.global_position)
		if d < best:
			best = d
			nearest = body
	if nearest:
		if nearest.has_method("take_damage"):
			nearest.take_damage(atk, Vector2.ZERO)
		if nearest.has_node("StatusEffect"):
			nearest.get_node("StatusEffect").apply_slow(0.4, 2.0)
