extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var addHealth = 25

func _on_body_entered(body: Node2D) -> void:
	animation_player.play("health_pickup")
	if body.has_method("health_pickup"):
		body.health_pickup(addHealth)
