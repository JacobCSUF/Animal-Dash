extends BaseObject
@onready var waterfall_small_363670: AudioStreamPlayer2D = $WaterfallSmall363670


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	var rnd = randf_range(0,4)
	waterfall_small_363670.play(rnd)
