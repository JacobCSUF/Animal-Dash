extends Node2D
const PIPE = preload("uid://dnncyh7xd3cbn")

var top_pipes = []
var bottom_pipes = []
@onready var timer: Timer = $Timer
var offset = 0
var speed = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(5):
		var pipe = PIPE.instantiate()
		var pipe2 = PIPE.instantiate()
		pipe.position = Vector2(64+(i*35),170)
		pipe2.position = Vector2(64+(i*35),30)
		pipe2.scale.y *= -1
		add_child(pipe)
		add_child(pipe2)
		top_pipes.append(pipe)
		bottom_pipes.append(pipe2)
		
	randomize()
	
func _physics_process(_delta: float) -> void:
	
	timer.wait_time = speed +.25
func _on_timer_timeout() -> void:
	offset = randi_range(0,1)
	if offset == 1:
		offset = -35
	else:
		offset = 35
	wave(top_pipes)
	wave(bottom_pipes)
		
func wave(pipes):
	for pipe in pipes:
		var old_position = pipe.position
		var tween = create_tween()
		tween.tween_property(pipe, "position",Vector2(pipe.position.x,pipe.position.y+offset) , speed)
		tween.tween_property(pipe, "position",Vector2(old_position) , speed)
		await get_tree().create_timer(0.25).timeout
		timer.start()
