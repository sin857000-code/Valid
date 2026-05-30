extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "산탄총"
	damage = 10
	range_radius = 50.0
	cooldown = 0.7
	item_color = Color(0.8, 0.5, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	super._apply_effect(player)
	player.set_meta("multishot", true)
