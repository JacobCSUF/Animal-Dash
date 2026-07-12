extends Node2D
class_name SoundHelper

@export var sound: AudioStreamPlayer2D
@export var audio_length:= 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sound:
		var r = randi_range(0,audio_length)
		sound.stop()
		sound.play(r)
