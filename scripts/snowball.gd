extends CharacterBody2D
@onready var snowball: Sprite2D = $Snowball

var speed: float = 150.0
var angle: float = 180.0

func _ready() -> void:
	velocity = Vector2.RIGHT.rotated(deg_to_rad(angle)) * speed

func set_up(speed_: float = 300.0, angle_: float = 0.0) -> void:
	speed = speed_
	angle = angle_
	velocity = Vector2.RIGHT.rotated(deg_to_rad(angle)) * speed


var time = 2.0
var counter  = 0

var check = true
func _physics_process(delta: float) -> void:
	if !check:
		move_and_slide()
		return
	counter += delta
	if counter >= time:
		death()
		check = false
	move_and_slide()
	
	
func death():
	var tween = create_tween()
	tween.tween_property(snowball,"scale",Vector2(0,0),1.0)
	tween.finished.connect(on_done)
	
func on_done():
	self.queue_free()


func _on_kill_area_body_entered(body: Node2D) -> void:
	self.queue_free()
