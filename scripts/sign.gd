
extends BaseObject

@export var sign_image_overide: Texture2D
@export var upside_down:= false
@export var is_bob:= true
@onready var sign_image: Sprite2D = $rotate/BaseSign/sign_image

@onready var block_particles: GPUParticles2D = $rotate/block_particles
@onready var base_sign: AnimatedSprite2D = $rotate/BaseSign

@onready var rotate: Node2D = $rotate




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sign_image_overide:
		sign_image.texture = sign_image_overide
		
	if upside_down:
		rotate.rotation_degrees = 180
		
		
	if !is_bob:
		bob = null
	super()
	
	var tween = create_tween().set_loops()
	tween.tween_property(sign_image,"modulate",Color(0.153, 0.153, 0.153, 1.0),0.2)
	tween.tween_property(sign_image,"modulate",Color(1.0, 1.0, 1.0, 1.0),0.2)
	tween.tween_interval(0.5)
	
