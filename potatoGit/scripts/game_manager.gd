extends Node

var score = 0

@onready var score_label = $"Score label"

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

 
