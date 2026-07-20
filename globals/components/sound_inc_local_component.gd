extends Node2D
class_name SoundIncLocalComponent

@export var sound: AudioStreamPlayer
@export var reg_sound: AudioManager.Sound

@export var number_of_steps:= 5


var starting_pitch = 1.0
var old_pitch = 1.0
var step = 1.059463

func setup_inc():
	if sound:
		old_pitch = sound.pitch_scale
		starting_pitch = sound.pitch_scale/(step**(number_of_steps/2.0))

func play_inc():
	sound.pitch_scale = starting_pitch
	sound.play()
	starting_pitch *= step
	

func reset_inc():
	starting_pitch = old_pitch
	
