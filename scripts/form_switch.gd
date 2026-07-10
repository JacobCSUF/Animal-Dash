extends Area2D
@export_enum("flappy", "ball", "float","cart") var selection: String = "flappy"


@export var invis: Node2D

var first = true



func _on_area_entered(area: Area2D) -> void:
	if !first:
			return
	first = false
	GameState.change_state(selection)
	if invis:
		invis.visible = false
