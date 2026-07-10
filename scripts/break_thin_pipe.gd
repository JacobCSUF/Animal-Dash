extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var pipe_break: AudioStreamPlayer2D = $PipeBreak
@onready var break_thin: Sprite2D = $BreakThin



@onready var particles: GPUParticles2D = $particles



const end_hit_scale := 1.15
var counter = 0





func _on_area_2d_area_entered(area: Area2D) -> void:
	if GameState.player.current_state_name == "dash":
		break_thin.visible = false
		particles.restart()
		particles.emitting = true
		pipe_break.play()
		
	else:
		GameState.die() 
