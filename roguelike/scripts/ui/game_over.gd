extends CanvasLayer

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var retry_button: Button = $VBoxContainer/RetryButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	score_label.text = "Score: %d" % GameManager.score
	retry_button.pressed.connect(_on_retry)
	quit_button.pressed.connect(_on_quit)

func _on_retry() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_quit() -> void:
	get_tree().quit()
