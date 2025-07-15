extends Area2D

@export var next_level: PackedScene


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		call_deferred("goto_level")

func goto_level() -> void:
	get_tree().change_scene_to_packed(next_level)
