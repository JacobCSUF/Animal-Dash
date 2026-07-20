extends Node2D

class_name SmokeChime

@export var auto_start:= false
@export var wait_time:= 3.0
@export var note_time := .15
@export var num:= 10

@onready var s1: SmokePipes = $small_pipe_steam
@onready var s2: SmokePipes = $small_pipe_steam2
@onready var s3: SmokePipes = $small_pipe_steam3
@onready var s4: SmokePipes = $small_pipe_steam4
@onready var s5: SmokePipes = $small_pipe_steam5


@onready var smoke_pipes: Array[SmokePipes] = [s1,s2,s3,s4,s5]
@onready var play: Timer = $play

var counter := 0
var dir = 1



func _ready():

	if auto_start:
		
		start_smoke_chime()
	play.stop()
	play.wait_time = wait_time


func start_smoke_chime():
	play.wait_time = wait_time
	await get_tree().create_timer(0.75).timeout
	_on_play_timeout()
	play.start()
	
func stop_smoke_chime():
	play.stop()

func play_scale() -> void:
	smoke_pipes[counter].play_move()
	counter += dir
	if counter == 0:
		dir = 1
	elif counter%(smoke_pipes.size() -1) == 0:
		dir = -1
	
	
	


func _on_play_timeout() -> void:
	for i in range(num):
		
		play_scale()
		await get_tree().create_timer(note_time).timeout
