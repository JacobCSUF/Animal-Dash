extends Node2D

@export var area: Area2D


@export_group("disappear")
@export var disappear:= false
@export var dis_target: Node2D

@export_group("move_trigger")
@export var target: Node2D
@export var loc1:= Vector2(0,1)
@export var distance:= 250
@export var speed:= 3.0

@export_group("auido_trigger")
@export var audio_player: AudioStreamPlayer2D
@export var rand_pitch:= 0.0

@export_group("auido2_trigger")
@export var audio_player2: AudioStreamPlayer2D
@export var rand_pitch2:= 0.0

@export_group("particle_trigger")
@export var play_at_body:= false
@export var particles: GPUParticles2D
@export var one_shot:= false


@export_group("animated_sprite")
@export var sprite: AnimatedSprite2D



func _ready() -> void:
	if area:
		area.area_entered.connect(_on_area_entered)


signal triggered(body)
# Called when the node enters the scene tree for the first time.

var first = true
func _on_area_entered(area: Node2D) -> void:

	if !first:
		return
	first = false
	
	if disappear:
		if dis_target:
			dis_target.visible = false
	
	
	if target:
		var b = MoveLineParams.new()
		b.direction = loc1
		b.distance = distance
		b.duration = speed
		AnimationUtils.move_in_line(target,b)
	
	if audio_player:
		var rand = randf_range(-rand_pitch,rand_pitch)
		audio_player.pitch_scale += rand
		audio_player.play()
		
	if audio_player2:
		var rand = randf_range(-rand_pitch2,rand_pitch2)
		audio_player2.pitch_scale += rand
		audio_player2.play()
		
	
	if particles:
		if play_at_body:
			particles.global_position=area.global_position
		if one_shot:
			particles.one_shot = true
		
		particles.emitting = true
	
	if sprite:
		sprite.play("default")
	
