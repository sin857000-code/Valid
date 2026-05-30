extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	item_name = "마법 지팡이"
	item_color = Color.VIOLET
	weapon_name = "마법 지팡이"
	damage = 25
	range_radius = 80.0  # 원거리
	cooldown = 1.0
	super._ready()
