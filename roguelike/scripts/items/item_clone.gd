extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_color = Color(0.7, 0.7, 1.0)
	super._ready()

func _apply_effect(player: Node) -> void:
	# Create a decoy clone that draws enemy fire for 5 seconds
	var clone = ColorRect.new()
	clone.size = Vector2(14, 14)
	clone.color = Color(0.7, 0.7, 1.0, 0.7)
	clone.global_position = player.global_position + Vector2(randi_range(-30, 30), randi_range(-30, 30)) - Vector2(7, 7)
	player.get_parent().add_child(clone)
	var t = clone.create_tween()
	t.tween_interval(5.0)
	t.tween_property(clone, "modulate:a", 0.0, 0.5)
	t.tween_callback(clone.queue_free)
	var hud = player.get_tree().get_first_node_in_group("hud")
	if hud:
		hud.show_weapon_pickup("환영 소환!")
