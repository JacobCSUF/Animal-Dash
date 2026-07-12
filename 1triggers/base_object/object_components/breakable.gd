extends Node2D
class_name Breakable

@export_group("Area Settings")
@export var num_hits = 1
@export var area_detection: Area2D
@export var requires_dash:= true
@export var auto_break:= false


@export_group("Animations")
@export var trigger: FuncTrigger
@export var audio: AudioManager.Sound
@export var audio_stream: AudioStreamPlayer2D

@export var make_invis: Array[Node2D] = []

signal signaled
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if area_detection:
		area_detection.area_entered.connect(_on_area_entered)
		
var first = true

func _on_area_entered(area: Node2D):
	
	if !first:
		return
	
	first = false
	if GameState.player.is_dash or  GameState.player.curr_group == Player.StateType.BALL or auto_break:
		if trigger:
			trigger.start_trigger()
			signaled.emit()
			
		if audio and audio!= AudioManager.Sound.DASH:
			AudioManager.play_sound(audio)
		
		if audio_stream:
			audio_stream.play()
			
		for i in make_invis:
			i.visible = false
		
	else: GameState.die()
	
