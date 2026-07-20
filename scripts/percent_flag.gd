extends Area2D

class_name PercentFlag
@onready var _1: Sprite2D = $"1"


@export var flag_index:= 0
@export_range(0.0,1.0) var flag_divide:= .5
@export var is_enter:= true

func _ready() -> void:
	_1.visible = false


func _on_area_entered(area: Area2D) -> void:
	if is_enter:
		print("ENTERED")
		GameState.player.distance_helper.change_mult(flag_divide)
		print(flag_divide)
	else:
		print("EXITED")
		GameState.player.distance_helper.change_mult(1.0)
