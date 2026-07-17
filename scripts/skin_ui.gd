extends Control
class_name SkinUI


@onready var frame: Node2D = $frame
@onready var animal: AnimatedSprite2D = $frame/animal
@onready var cost: Label = $frame/cost


func _ready() -> void:
	toggle_off()

func set_animal(anim_frames: SpriteFrames):
	animal.sprite_frames = anim_frames
	animal.animation = "flappy"



func toggle_off():
	frame.modulate = Color(0.605, 0.605, 0.605, 0.553)
	cost.visible = false
	animal.stop()
	
func toggle_on():
	
	frame.modulate = Color(1.0, 1.0, 1.0, 1.0)
	cost.visible = true
	animal.play("flappy")
