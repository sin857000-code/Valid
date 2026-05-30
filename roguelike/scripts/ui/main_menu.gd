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

	continue_button.pressed.connect(_on_continue)
	new_game_button.pressed.connect(_on_new_game)
	quit_button.pressed.connect(_on_quit)

func _on_continue() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_new_game() -> void:
	GameManager.delete_save()
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/maps/dungeon.tscn")

func _on_quit() -> void:
	get_tree().quit()
