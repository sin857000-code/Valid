extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.5, 0.8, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Periodic shield that regenerates every 15s
	player.set_meta("auto_shield_timer", 0.0)
	player.set_meta("auto_shield_interval", 15.0)
	# Give immediate shield too
	player.set_meta("shield", true)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("자동 방어막! 15초마다 재생")
