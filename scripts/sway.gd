extends Node2D


@export_group("sway Settings")
@export var sway := false
@export var width := 2.0
@export var duration := 0.4
@export var speed := 0.8



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p = get_parent()
	if sway:
		var x = SwayParams.new()
		x.width = width
		x.duration = duration
		x.speed = speed
		AnimationUtils.start_sway(p,x)
