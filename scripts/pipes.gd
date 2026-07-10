extends Node2D
@export var is_bob:= false
@export var shader:= false
@onready var pipe: Node2D = $pipe
@onready var pipe_2: Node2D = $pipe2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pipe.is_bob = is_bob
	pipe_2.is_bob = is_bob
	
	pipe.shader = shader
	pipe_2.shader = shader
	
	
