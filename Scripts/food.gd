extends Area2D

var amount_given: int = 100

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.consume(amount_given)
		queue_free()
