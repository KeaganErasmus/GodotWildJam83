extends Control

@onready var light: PointLight2D = $PointLight2D
var mouse_pos: Vector2

func _ready() -> void:
	MusicPlayer.play_menu_music()

func _process(_delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	light.position = mouse_pos


func _on_play_button_pressed() -> void:
	MusicPlayer.stop_menu_music()
	get_tree().change_scene_to_file("res://Scenes/tutorial_level.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
