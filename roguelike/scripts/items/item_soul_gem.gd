extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "Soul Gem"
	item_color = Color(0.7, 0.0, 1.0)
	super._ready()

func apply_effect(player) -> void:
	var bonus = player.get_meta("kill_score_bonus") if player.has_meta("kill_score_bonus") else 0
	player.set_meta("kill_score_bonus", bonus + 10)
	var exp_mult = player.get_meta("exp_mult") if player.has_meta("exp_mult") else 1.0
	player.set_meta("exp_mult", exp_mult + 0.3)
