extends Node2D

class_name SmokePipes

@export var off := true


@onready var steam_burst_6823: AudioStreamPlayer = $SteamBurst6823
@onready var timer: Timer = $Timer
@onready var smoke: GPUParticles2D = $smoke


var dir = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if off:
		timer.stop()
		return
		
	var rng= randf_range(1.0,3.0)
	timer.wait_time = rng
	timer.start()
	var rn = randi_range(0,1)
	if rn == 0:
		dir = 1
		
		
func play_move():
	
	var tween = create_tween()
	tween.tween_property(self,"position",position+Vector2(0,15* dir),.2)
	dir *= -1
	AudioManager.play_scale(AudioManager.Scale.SMOKE,self.global_position)
	smoke.restart()
	smoke.emitting = true
	


func _on_timer_timeout() -> void:
	play_move()
	
	var rng= randf_range(1.0,3.0)
	timer.wait_time = rng
	
