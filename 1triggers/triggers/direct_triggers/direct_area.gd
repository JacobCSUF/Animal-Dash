extends Trigger

func _ready() -> void:
	set_direct(true)
	super()

var first = true



func _on_area_entered(area: Area2D) -> void:
	if first:
		first = false
		trigger()
