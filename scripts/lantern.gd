extends Trigger
class_name  Lantern



@onready var lantern1: AnimatedSprite2D = $lantern

@onready var fire: Node2D = $fire
@onready var flame: AnimatedSprite2D = $fire/flame
@onready var outline: AnimatedSprite2D = $fire/outline


@onready var point_light_2d: PointLight2D = $PointLight2D


@onready var campfire: AudioStreamPlayer2D = $Campfire
@onready var torch_aura: AudioStreamPlayer2D = $TorchAura

@onready var fire_particle: GPUParticles2D = $fire/outline/fire_particle


signal lantern_hit
var first = true
var lantern_index = 0
var triggered = false



	
	
func set_color(f: Color, c: Color):
	point_light_2d.color = f
	flame.modulate = f
	outline.modulate = c
	
		
func set_on(index: int):
	lantern_index = 0
	fire.visible = true
	campfire.play()
	point_light_2d.visible = true
	lantern1.pause()
	lantern1.frame = 1

func auto_on():
	campfire.play()
	fire.visible = true
	point_light_2d.visible = true
	lantern1.frame = 1
	triggered = true
	
func is_trigger():
	return triggered


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !first:
		return
	first = false
	
	
	lantern_hit.emit(area)
	if !triggered:
		torch_aura.play()
		set_on(0)
	else:
		torch_aura.volume_db -= 5
		torch_aura.pitch_scale = 2.5
		torch_aura.play()
	triggered = true
