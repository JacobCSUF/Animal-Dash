extends Node2D
class_name MovementComponent

enum MovementType{BOB,SWAY,MOVE,SHRINK,SPIN}

@export var moveable_object: Node2D

var current_animation: Tween
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if moveable_object:
		pass

func set_object(obj: Node2D):
	moveable_object = obj



##########MOVEMENTS#########################################################
func bob(data: BobParams):
	stop_ani()
	current_animation = AnimationUtils.start_bob(moveable_object,data)

func move_in_line(data: MoveLineParams):
	stop_ani()
	current_animation = AnimationUtils.move_in_line(moveable_object,data)

func shrink(data: ShrinkParams):
	stop_ani()
	current_animation = AnimationUtils.shrink_stretch(moveable_object,data)

func spin(data: SpinParams):
	stop_ani()
	current_animation = AnimationUtils.spin(moveable_object,data)
	
func sway(data: SwayParams):
	stop_ani()
	current_animation = AnimationUtils.start_sway(moveable_object,data)
	
func stop_ani():
	if current_animation:
		current_animation.kill()
		
	
