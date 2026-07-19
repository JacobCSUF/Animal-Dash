extends Node2D
class_name DistanceHelper
@onready var player: Player = $".."


var level_distance := 0.0
var traveled := 0.0
var mult:= 1.0



func get_distance(distance:= 0):
	level_distance = distance


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(traveled)
	if player.velocity.x >= 0:
		traveled += player.velocity.x*delta * mult
	
		

func change_mult(new_mult:= 1):
	mult += new_mult

func get_percent():
	return 100*(traveled/level_distance)

func player_died():
	
	return round(100*(traveled/level_distance))
