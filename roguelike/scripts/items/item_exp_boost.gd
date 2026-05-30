extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "경험치 부스트"
	item_color = Color(0.9, 0.9, 0.2)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Instantly grant EXP equal to half the next level threshold
	var bonus_exp = GameManager.exp_to_next() / 2
	GameManager.add_exp(bonus_exp)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(player.get_parent(), player.global_position, Color(0.9, 0.9, 0.2))
