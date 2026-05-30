extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "Speed Up"
	item_color = Color(0.3, 0.8, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	player.move_speed_bonus = min(player.move_speed_bonus + 0.25, 2.5)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(player.get_parent(), player.global_position, Color(0.3, 0.8, 1.0))
