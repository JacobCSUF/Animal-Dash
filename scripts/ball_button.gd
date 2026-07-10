extends BaseObject

@export var area_entered: Array[ResponseResource]
@onready var ball_trigger: AnimatedSprite2D = $BallTrigger
@onready var beep: AudioStreamPlayer2D = $Beep
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D




var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_up_trigger(area_entered)
	tween = create_tween().set_loops()
	tween.tween_property(ball_trigger,"modulate",Color(0.405, 0.405, 0.405, 1.0),0.2)
	tween.tween_interval(0.075)
	tween.tween_property(ball_trigger,"modulate",Color(1.0, 1.0, 1.0, 1.0),0.2)
	tween.tween_interval(0.075)

var first = true


func _on_direct_area_area_entered(area: Area2D) -> void:
	if !first:
			return
	first = false
	ball_trigger.modulate = Color(1.0, 1.0, 1.0, 1.0)
	ball_trigger.frame += 1
	tween.kill()
	beep.play()
	gpu_particles_2d.emitting = true
