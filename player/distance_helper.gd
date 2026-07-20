extends Node2D
class_name DistanceHelper
@onready var player: Player = $".."


var level_distance := 0.0
var traveled := 0.0
var mult:= 1.0



func get_distance(distance:= 0):
	level_distance = distance
	


func _process(delta: float) -> void:
	
	if player.velocity.x >= 0.0:
		traveled += player.velocity.x*delta * mult
		
	#print(traveled)
		

func change_mult(new_mult:= 1.0):
	mult = new_mult
	
func get_percent():
	#print(traveled,' TRAB')
	
	return 100.0*(traveled/level_distance)

func player_died():
	
	return round(100*(traveled/level_distance))
