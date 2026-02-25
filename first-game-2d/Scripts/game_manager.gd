extends Node
@onready var score_label: Label = $CanvasLayer/score_label

var score:int = 0
# Adds a point to the score label on screen
func add_point():
	score += 1
	print(score)
	score_label.text = "Score: " + str(score)
