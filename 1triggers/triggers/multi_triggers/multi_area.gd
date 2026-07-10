extends Trigger

var first = true

	
func _on_area_entered(area: Area2D) -> void:
	if first:
		first = false
		trigger()
