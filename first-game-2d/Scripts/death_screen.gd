extends CanvasLayer

@onready var retry_button: Button = $Control/retry_button
# draws a reset button and handles the reset
func _on_retry_button_pressed() -> void:
	var button = Button.new()
	button.text = "Retry?"
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
