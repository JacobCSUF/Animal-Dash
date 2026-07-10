extends Node
class_name PlayerState

@export var state_type: Player.StateType

var player: Player 

func enter_state(player_node: Player, _dict = {}):
	player = player_node

func exit_state():
	pass
	
func handle_input(_delta):
	pass
