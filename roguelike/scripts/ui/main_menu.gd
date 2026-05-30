extends CanvasLayer

@onready var continue_button: Button = $VBox/ContinueButton
@onready var new_game_button: Button = $VBox/NewGameButton
@onready var quit_button: Button = $VBox/QuitButton
@onready var save_info: Label = $VBox/SaveInfo

func _ready() -> void:
	var has_save = GameManager.has_save()
	continue_button.visible = has_save
	if has_save:
		GameManager.load_save()
		save_info.text = "저장된 게임: Floor %d  Lv.%d  Score %d" % [
			GameManager.current_floor, GameManager.level, GameManager.score
		]
	else:
		save_info.text = "저장된 게임 없음"

	var hs = load("res://scripts/core/high_score.gd")
	var best = hs.get_best_score()
	if best > 0:
		var best_lbl = Label.new()
		best_lbl.text = "최고 점수: %d" % best
		best_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		best_lbl.modulate = Color(1.0, 0.85, 0.2)
		$VBox.add_child(best_lbl)
		$VBox.move_child(best_lbl, 0)

	_spawn_bg_particles()

	continue_button.pressed.connect(_on_continue)
	new_game_button.pressed.connect(_on_new_game)
	quit_button.pressed.connect(_on_quit)

func _spawn_bg_particles() -> void:
	for i in range(30):
		var p = ColorRect.new()
		var sz = randf_range(2, 6)
		p.size = Vector2(sz, sz)
		p.color = Color(randf_range(0.2, 0.6), randf_range(0.1, 0.4), randf_range(0.5, 1.0), randf_range(0.3, 0.7))
		p.position = Vector2(randf_range(0, 1280), randf_range(0, 720))
		$Background.add_child(p)
		var duration = randf_range(4.0, 10.0)
		var target_y = p.position.y - randf_range(200, 500)
		var tween = p.create_tween().set_loops()
		tween.tween_property(p, "position:y", target_y, duration)
		tween.tween_property(p, "position:y", 750.0, 0.01)
		tween.tween_property(p, "modulate:a", randf_range(0.3, 0.7), duration)

func _on_continue() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_new_game() -> void:
	GameManager.delete_save()
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_quit() -> void:
	get_tree().quit()
