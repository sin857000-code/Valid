extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Chain Whip"
	damage = 24
	range_radius = 110.0
	cooldown = 1.0
	item_color = Color(0.7, 0.5, 0.2)
	super._ready()
