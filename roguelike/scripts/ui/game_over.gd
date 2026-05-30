extends CanvasLayer

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var level_label: Label = $VBoxContainer/LevelLabel
@onready var best_label: Label = $VBoxContainer/BestLabel
@onready var retry_button: Button = $VBoxContainer/RetryButton
@onready var menu_button: Button = $VBoxContainer/MenuButton

func _ready() -> void:
	var hs = load("res://scripts/core/high_score.gd")
	hs.save_score(GameManager.score, GameManager.current_floor, GameManager.level)

	score_label.text = "Score: %d" % GameManager.score
	level_label.text = "Level %d  |  Floor %d" % [GameManager.level, GameManager.current_floor]
	best_label.text = "Best: %d" % hs.get_best_score()

	GameManager.delete_save()
	retry_button.pressed.connect(_on_retry)
	menu_button.pressed.connect(_on_menu)

func _on_retry() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_menu() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
