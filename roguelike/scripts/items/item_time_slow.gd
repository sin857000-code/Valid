extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.5, 0.3, 0.8)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Slow all enemies for 3 seconds
	for body in player.get_tree().get_nodes_in_group("enemy"):
		if body.has_method("get") and body.get("status") != null:
			body.status.apply_slow(0.1, 3.0)
		elif body.has_method("get") and body.get("_stun_timer") != null:
			body._stun_timer = 1.5
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("시간 정지! 모든 적 감속!")
