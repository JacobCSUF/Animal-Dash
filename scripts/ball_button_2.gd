extends BaseObject

@export var area_entered: Array[ResponseResource]
@onready var ball_trigger: AnimatedSprite2D = $ball_trigger

@onready var beep: AudioStreamPlayer2D = $Beep


var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_up_trigger(area_entered)
	tween = create_tween().set_loops()
	tween.tween_property(ball_trigger,"modulate",Color(0.527, 0.527, 0.527, 1.0),0.2)
	tween.tween_interval(0.1)
	tween.tween_property(ball_trigger,"modulate",Color(1.0, 1.0, 1.0, 1.0),0.2)
	tween.tween_interval(0.1)


	

func _on_direct_area_area_entered(area: Area2D) -> void:
	ball_trigger.modulate = Color(1.0, 1.0, 1.0, 1.0)
	ball_trigger.frame += 1
	tween.kill()
	beep.play()
