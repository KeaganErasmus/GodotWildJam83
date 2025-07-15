extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready() -> void:
	animation_player.play("scanning")


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
