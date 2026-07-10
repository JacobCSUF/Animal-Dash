extends Node2D
@export 	var hits_to_break := 3

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var pipe_break: AudioStreamPlayer2D = $PipeBreak
@onready var pipe_hit: AudioStreamPlayer2D = $PipeHit
@onready var broken_pipe: AnimatedSprite2D = $BrokenPipe

@onready var shard: GPUParticles2D = $shard
@onready var numbers: AnimatedSprite2D = $numbers
@onready var digital_sound: AudioStreamPlayer2D = $DigitalSound
@onready var hit_ani: AnimationPlayer = $hit_ani


const end_hit_scale := 1.15
var counter = 0

func set_hits(hits):
	broken_pipe.frame = 3 - hits
	numbers.frame = broken_pipe.frame

func _ready() -> void:
	pipe_hit.pitch_scale = end_hit_scale - (.2*hits_to_break)
	digital_sound.pitch_scale = .8 - (.15*hits_to_break)
	counter = hits_to_break
	broken_pipe.frame = 3- hits_to_break
	numbers.frame = broken_pipe.frame

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.is_dash or body.curr_group == Player.StateType.BALL:
			
			if hits_to_break > 1:
				hit_ani.play("hit")
				shard.restart()
				shard.amount = 5
				shard.emitting = true
				
				ParticleManager.play_particle(ParticleManager.particles.BLOCK,shard.global_position)
				
				
				broken_pipe.frame += 1
				numbers.frame += 1
				hits_to_break -= 1
				digital_sound.play()
				digital_sound.pitch_scale += .1
				pipe_hit.play()
				pipe_hit.pitch_scale += .2
				GameState.change_state("dash_recoil")
				
				return
			else:
				numbers.frame += 1
				
				ParticleManager.play_particle(ParticleManager.particles.BLOCK,shard.global_position)
				
				pipe_break.play()
				digital_sound.pitch_scale += .1
				digital_sound.play()
				broken_pipe.visible = false
				
				shard.restart()
				shard.amount = 15
				shard.emitting = true
		else:
			GameState.die() 
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if GameState.player.is_dash or GameState.player.curr_group == Player.StateType.BALL:
			
		if hits_to_break > 1:
			hit_ani.play("hit")
			shard.restart()
			shard.amount = 5
			shard.emitting = true
			
			ParticleManager.play_particle(ParticleManager.particles.BLOCK,shard.global_position)
			
			
			broken_pipe.frame += 1
			numbers.frame += 1
			hits_to_break -= 1
			digital_sound.play()
			digital_sound.pitch_scale += .1
			pipe_hit.play()
			pipe_hit.pitch_scale += .2
			GameState.change_state("dash_recoil")
			
			return
		else:
			numbers.frame += 1
			
			ParticleManager.play_particle(ParticleManager.particles.BLOCK,shard.global_position)
			
			pipe_break.play()
			digital_sound.pitch_scale += .1
			digital_sound.play()
			broken_pipe.visible = false
			
			shard.restart()
			shard.amount = 15
			shard.emitting = true
	else:
		GameState.die() 
	
