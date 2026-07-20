extends Resource
class_name ScaleResource

@export var sound: AudioStream
@export var volume:= -15.0
@export var start_pitch:= 1.0
@export var steps = 12

var curr_pitch
var up = true
var counter = 0
var first = true



func return_pitch():
	
	if first:
		
		first = false
		curr_pitch = start_pitch
		counter += 1
	
		return start_pitch
	
	if counter >= steps:
		up = false
	elif counter <= 1:
		up = true
	
	if up:
		curr_pitch *= 1.059463
		counter += 1
	else:
		curr_pitch /= 1.059463
		counter -= 1

	return curr_pitch
