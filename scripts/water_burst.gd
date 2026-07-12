extends Node2D

@export var is_burst:= false
@export_range(0,360) var angle:= 90
@export var volume_overide:= 0

@onready var water: GPUParticles2D = $water
@onready var water_flow: AudioStreamPlayer2D = $WaterFlow
@onready var burst: AudioStreamPlayer2D = $Burst



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if is_burst:
		water.rotation_degrees = angle + self.rotation_degrees
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
