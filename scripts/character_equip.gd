extends Node2D


@onready var left: AnimatedSprite2D = $"Settings Title2/left"
@onready var mid: AnimatedSprite2D = $"Settings Title2/mid"
@onready var right: AnimatedSprite2D = $"Settings Title2/right"

const BAT_FRAMES = preload("uid://b5oas7vd18qh3")

var frames = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(5):
		frames.append(BAT_FRAMES)



func get_animals(animals: Array):
	pass



func _on_left_pressed() -> void:
	pass # Replace with function body.


func _on_right_pressed() -> void:
	pass # Replace with function body.
