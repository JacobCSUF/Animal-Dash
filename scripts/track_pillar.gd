extends Node2D
class_name TrackPillar

@export var broken:= false
@onready var track_pillar: Sprite2D = $TrackPillar
@onready var track_broken_pillar: Sprite2D = $TrackBrokenPillar
@onready var wood_break: GPUParticles2D = $wood_break
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D




func set_broken():
	broken = true
	track_pillar.visible = false
	track_broken_pillar.visible = true

func destroy():
	if broken:
		wood_break.emitting = true
		track_broken_pillar.visible =  false
		collision_shape_2d.call_deferred("set_disabled",true)
	
