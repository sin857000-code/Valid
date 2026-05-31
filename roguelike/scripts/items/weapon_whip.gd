extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Whip"
	damage = 14
	range_radius = 95.0
	cooldown = 0.7
	item_color = Color(0.8, 0.5, 0.2)
	super._ready()
