extends Node2D

@export var is_down:= false
@export var speed:= 4.0


@onready var area_trigger: Area2D = $AREA_TRIGGER
@onready var pipe_crane: Sprite2D = $CraneLift/PipeCrane


func _ready():
	if is_down:
		area_trigger.loc1 = Vector2(0,1)
	area_trigger.speed = speed
	var b = BobParams.new()
	b.height = 1.4
	b.duration = .5
	b.speed =2
	b.random = true
	AnimationUtils.start_bob(pipe_crane,b)
