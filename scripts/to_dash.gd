extends BaseObject

@export var quiet:= false

@onready var blow_dryer: AudioStreamPlayer2D = $BlowDryer


@onready var speed: AudioStreamPlayer2D = $speed

func _ready() -> void:
	super()
	if quiet:
		blow_dryer.volume_db = -40
		speed.volume_db = -22



func finish():
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1),.1)
	


func _on_dash_area_area_entered(area: Area2D) -> void:
	speed.play()
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(.85,.85),.1)
	tween.finished.connect(finish)
