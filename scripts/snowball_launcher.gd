extends Node2D

@export var launch_timer: float = 1.0
@export_range(0.0,20.0) var turn_degrees = 5.0
@export_range(0.0,20.0) var shoot_degrees = 5.0
@onready var timer: Timer = $Timer
@onready var move: Node2D = $move
@onready var sprite_2d: Sprite2D = $move/sprite_2d
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var launch_pos: Node2D = $move/sprite_2d/launch_pos
@onready var cannon_shot_326182: AudioStreamPlayer2D = $SnowBallShot

var multi_balls = false
var multi_balls_counter = 0

const SNOWBALL = preload("uid://cd5hiaxg1c0sq")


var base_rot := 0.0   # original rotation

func _ready() -> void:
	timer.wait_time = launch_timer
	randomize()
	base_rot = rotation_degrees
	
	start_oscillation()


func start_oscillation():
	var tween = create_tween()
	tween.set_loops()  # infinite loop

	# Rotate to -10° from original
	tween.tween_property(self, "rotation_degrees", base_rot - turn_degrees, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Rotate to +10° from original
	tween.tween_property(self, "rotation_degrees", base_rot + turn_degrees, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_timer_timeout() -> void:
	animation_player.play("shoot")
	ball_attack()


func ball_attack():
	AudioManager.play_unreg_sound(cannon_shot_326182,.1)
	
	
	var rng_angle = randi_range(-shoot_degrees, shoot_degrees)
	var orb = SNOWBALL.instantiate()
	orb.global_position = launch_pos.global_position
	orb.angle = 180 + rng_angle + rotation_degrees
	orb.speed = 150
	get_tree().get_root().add_child(orb)
