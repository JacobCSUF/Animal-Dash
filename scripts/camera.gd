@tool
extends Camera2D


@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	self.make_current()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("end"):
		print('REEEEEEEEEEEEEEEE')
		follow = false

		
var follow = true
func _process(delta: float) -> void:
	
	if follow and player:
		self.global_position = player.global_position
