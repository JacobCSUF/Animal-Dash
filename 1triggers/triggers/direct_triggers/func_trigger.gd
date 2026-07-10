extends Trigger
class_name FuncTrigger

func _ready() -> void:
	set_direct(true)
	super()

func start_trigger() -> void:
	trigger()
