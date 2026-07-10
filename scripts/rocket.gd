extends BaseObject
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sizzle: AudioStreamPlayer2D = $Sizzle
@onready var fireworkshoot: AudioStreamPlayer2D = $Fireworkshoot
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var node_2d: Node2D = $AnimatedSprite2D/Node2D

var launch_height: float = 0.0

var first = true


func _on_animated_sprite_2d_animation_finished() -> void:
	sizzle.stop()
	fireworkshoot.pitch_scale = 1.0 + randf_range(-0.2, 0.2)
	fireworkshoot.play()
	launch_height = -150.0 + randf_range(-50.0, 50.0)
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "position", animated_sprite_2d.position + Vector2(0, launch_height), 0.40)
	tween.finished.connect(_on_tween_finished)
	
func _on_tween_finished():
	fireworkshoot.stop()
	

	AudioManager.play_sound(AudioManager.Sound.FIREWORK)
	
	
	gpu_particles_2d.global_position = node_2d.global_position
	gpu_particles_2d.emitting = true
	animated_sprite_2d.visible = false
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !first:
			return
	first = false
	animated_sprite_2d.play("spark")
	sizzle.play()
