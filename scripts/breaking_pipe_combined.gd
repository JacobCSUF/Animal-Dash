extends BaseObject
@export var hits_to_break := 3
@onready var breaking_pipe: Node2D = $breaking_pipe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	breaking_pipe.hits_to_break = hits_to_break
	breaking_pipe.set_hits(hits_to_break)
