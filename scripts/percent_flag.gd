extends Area2D

class_name PercentFlag


@export var flag_index:= 0
@export_range(0.0,1.0) var flag_divide:= .5
@export var is_enter:= true




func _on_area_entered(area: Area2D) -> void:
	if is_enter:
		GameState.player.distance_helper.change_mult(-flag_divide)
	else:
		GameState.player.exit_flag(flag_divide)
