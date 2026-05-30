extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "Stun Grenade"
	item_color = Color(0.8, 0.8, 0.2)
	super._ready()

func apply_effect(player) -> void:
	for body in player.get_tree().get_nodes_in_group("enemies"):
		if player.global_position.distance_to(body.global_position) < 120.0:
			if body.has_method("get") and body.get("_stun_timer") != null:
				body._stun_timer = 2.5
