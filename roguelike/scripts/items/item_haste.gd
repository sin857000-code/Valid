extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "Haste Charm"
	item_color = Color(1.0, 1.0, 0.3)
	super._ready()

func apply_effect(player) -> void:
	var spd = player.get_meta("speed_mult") if player.has_meta("speed_mult") else 1.0
	player.set_meta("speed_mult", min(spd + 0.2, 2.0))
	if player.has_method("get") and player.get("move_speed") != null:
		player.move_speed = player.move_speed * 1.2
