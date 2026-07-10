extends Node2D
@export var left_pillars: Array[TrackPillar] = []
@export var right_pillars: Array[TrackPillar] = []
@onready var crate_break: AudioStreamPlayer2D = $CrateBreak

@export var l:= 0
@export var r:= 0

var has_break = false
func _ready() -> void:
	for i in range(l):
		left_pillars[i].set_broken()
		has_break = true
	for i in range(r):
		right_pillars[i].set_broken()
		has_break = true

var first = true
func _on_direct_area_area_entered(area: Area2D) -> void:
	if !first:
		return
	first = false
	
	
	for i in left_pillars:
		if i.broken:
			i.destroy()
	
	for i in right_pillars:
		if i.broken:
			i.destroy()	
	
	if has_break:
		crate_break.play()
