extends Area2D

@export var damage: float = 25
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		print(body.health)
	if body.health <=0:
		body.die()
