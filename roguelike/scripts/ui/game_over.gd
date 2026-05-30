extends CanvasLayer

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var level_label: Label = $VBoxContainer/LevelLabel
@onready var best_label: Label = $VBoxContainer/BestLabel
@onready var retry_button: Button = $VBoxContainer/RetryButton
@onready var menu_button: Button = $VBoxContainer/MenuButton

func _ready() -> void:
	var hs = load("res://scripts/core/high_score.gd")
	hs.save_score(GameManager.score, GameManager.current_floor, GameManager.level)

	score_label.text = "Score: %d  |  Kills: %d" % [GameManager.score, GameManager.kills]
	var best_t = GameManager.best_floor_time
	var time_str = ("Best floor time: %.1fs" % best_t) if best_t < 9999.0 else ""
	level_label.text = "Level %d  |  Floor %d  %s" % [GameManager.level, GameManager.current_floor, time_str]
	var scores = hs.get_scores()
	if scores.size() > 0:
		best_label.text = "Best: %d" % scores[0].get("score", 0)
		for i in range(min(3, scores.size())):
			var s = scores[i]
			var lbl = Label.new()
			lbl.text = "#%d  %d pts  Lv%d  F%d" % [i+1, s.get("score",0), s.get("level",1), s.get("floor",1)]
			lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			lbl.modulate = Color(1.0, 0.85, 0.2) if i == 0 else Color(0.8, 0.8, 0.8)
			$VBoxContainer.add_child(lbl)
			$VBoxContainer.move_child(lbl, $VBoxContainer.get_child_count() - 3)

	GameManager.delete_save()
	retry_button.pressed.connect(_on_retry)
	menu_button.pressed.connect(_on_menu)

func _on_retry() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_menu() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
