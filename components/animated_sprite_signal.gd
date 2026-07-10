extends AnimatedSprite2D
class_name  AnimatedSpriteSignaled

@export var signaler: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signaler.signaled.connect(_on_signaled)
	
func _on_signaled():
	if sprite_frames.has_animation("default"):
		play("default")
