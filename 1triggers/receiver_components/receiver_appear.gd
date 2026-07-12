extends Node2D


@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var target_pos: Vector2



func handle(pos, target: Node2D):
	gpu_particles_2d.visible = false
	target_pos = target.global_position
	
	
	AudioManager.play_sound(AudioManager.Sound.FAIRYD)

		
	gpu_particles_2d.global_position = pos
	gpu_particles_2d.visible = true
	var time = gpu_particles_2d.global_position.distance_to(target_pos)*.0017
	gpu_particles_2d.emitting = true
		
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(gpu_particles_2d, "global_position",target_pos, time)
	tween.finished.connect(_on_tween_finished.bind(target))


@onready var smoke: GPUParticles2D = $smoke
@onready var appear: AudioStreamPlayer = $Appear

func _on_tween_finished(target):
	smoke.restart()
	smoke.emitting = true
	smoke.global_position = target_pos
	appear.play()
	AudioManager.play_scale(AudioManager.Scale.APPEAR)
	if target:
		
		target.visible = true
		target.process_mode = Node.PROCESS_MODE_INHERIT
	gpu_particles_2d.emitting = false
	
