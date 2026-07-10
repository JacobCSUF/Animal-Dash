@tool
extends BaseObject

@export var distance:= 0
# Called when the node enters the scene tree for the first time.
@onready var pipe: BaseObject = $pipe

func _ready() -> void:
	super()
	pipe.position.y += distance
