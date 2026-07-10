extends BaseObject

@export var area_entered: Array[ResponseResource]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_up_trigger(area_entered)
