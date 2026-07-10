extends BaseObject

@export_range(0,4) var stage:= 0

@onready var pipe: Node2D = $"pipe/stretch pipe"
@onready var splash: GPUParticles2D = $"pipe/stretch pipe/splash"
@onready var splash_2: GPUParticles2D = $"pipe/stretch pipe/splash2"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var water_splash_1: AudioStreamPlayer2D = $WaterSplash1
@onready var area_2d: Area2D = $"pipe/stretch pipe/Area2D"

var tween: Tween

func _ready() -> void:
	area_2d.position.y -= 25*stage


func _on_direct_area_area_entered(area: Area2D) -> void:
	tween = create_tween()
	tween.tween_property(pipe,"position",Vector2(pipe.position + Vector2(0,300)),1.0)




func _on_area_2d_body_entered(body: Node2D) -> void:
	water_splash_1.play()
	tween.kill()
	splash.emitting = true
	splash_2.emitting = true
	animation_player.play("fall")
	var bp = BobParams.new()
	bp.height = 3.0
	AnimationUtils.start_bob(pipe,bp)
