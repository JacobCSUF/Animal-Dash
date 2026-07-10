extends Resource
class_name LevelResource


@export var level_name := 'Default Name'
@export_range(1,10) var level_number = 1
@export var lantern_color:= Color(0.208, 0.671, 1.0, 1.0)
@export var ui_color: Color
@export var total_coins:= 30



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
