extends Node2D
class_name  SoundIncComponent

@export var sound: AudioStreamPlayer2D
@export var area: Area2D
@export var sound_type: SoundIncManager.inc_type
@export var signal1: Node2D

@export_group("Registered Sound")
@export var reg_sound: AudioManager.Sound
@export var pos: Node2D


var number_group = 0
var pitch = 1.0

signal play_sound(num: int, t: SoundIncManager.inc_type,b: SoundIncComponent)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if area:
		area.area_entered.connect(_on_entered)

	if signal1:
		signal1.signaled.connect(_on_signaled)
		
func _on_signaled():
	handle_sound()
	

func _on_entered(_area1: Node2D):
	handle_sound()


var first = true
func handle_sound():
	if !first:
		return
	first = false
	if number_group != 0:
		play_sound.emit(number_group,sound_type,self)
	else:
		play_s()
		
	
func send_pitch(pitch1: float):
	pitch = pitch1
	play_s()
	
	
	
func set_number(num: int):
	number_group = num
	
	
func play_s():

	if sound:

		if number_group <= 0:
			sound.play()
		else:
			sound.pitch_scale = pitch
			sound.play()
		
	else:
		
		var p = Vector2(0,0)
		
		if pos:
			p = pos.global_position
		if number_group > 0:
			var data = SoundParams.new()
			data.pitch = pitch
			data.is_pitch_overide = true
			AudioManager.route_sound(reg_sound,p,data)
		else:
			AudioManager.route_sound(reg_sound,p)
		
	
		
