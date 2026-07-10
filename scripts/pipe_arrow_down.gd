extends BaseObject

@export var base_dir:= Vector2(0,1)
@export var arrow_flip:= false
@export var distance:= 0
@onready var arrow: AnimatedSprite2D = $arrow


func _ready() -> void:
	super()
	if arrow_flip:
		base_dir *= -1
		arrow.flip_v = true




func _on_direct_area_area_entered(area: Area2D) -> void:
	var m:= MoveLineParams.new()

	m.direction = base_dir
	m.duration = 0.5
	m.distance = 65
	AnimationUtils.move_in_line(self,m)
	arrow.stop()
	arrow.frame = 0
