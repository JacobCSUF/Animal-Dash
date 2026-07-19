
extends Node2D

@export var is_burst:= false
@export_range(0,360) var angle:= 90
@export var volume_overide:= 0
@export var area_increase := 0
@onready var water: GPUParticles2D = $water
@onready var water_flow: AudioStreamPlayer2D = $WaterFlow
@onready var burst: AudioStreamPlayer2D = $Burst

@onready var area_2d: Area2D = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.global_position = global_position - Vector2(area_increase,0)
	if is_burst:
		if get_parent() == Node2D:
			
			water.rotation_degrees = angle + get_parent().rotation_degrees
		else:
			water.rotation_degrees = angle
		self.visible = false
		water.emitting = false
		water_flow.stop()

	if volume_overide!= 0:
		water_flow.volume_db = volume_overide


		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_burst:
		self.visible = true
		water.emitting = true
		var rnd = randf_range(-.2,.2)
		burst.pitch_scale += rnd
		burst.play()
		water_flow.play()
