extends Node2D



@export var is_bg:= false
@export var location:= bg.FRONT

enum bg{FRONT,MID,BACK}

@onready var wf: Sprite2D = $Waterfall
@onready var water_splash_1: AudioStreamPlayer2D = $Waterfall/WaterSplash1
@onready var particles: GPUParticles2D = $particles
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var waterfall: AudioStreamPlayer2D = $Waterfall/waterfall

const WATERFALL_DARKER = preload("uid://bcvfn6fkkyj5g")
const WATERFALL_MID = preload("uid://cl7hf5dpi7q00")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_bg:
		collision_shape_2d.disabled = true
		waterfall.stop()
	
	if location == bg.MID:
		wf.texture = WATERFALL_MID
	elif location == bg.BACK:
		wf.texture = WATERFALL_DARKER



func _on_area_2d_area_entered(area: Area2D) -> void:
	water_splash_1.play()
	particles.global_position = area.global_position
	particles.emitting = true
