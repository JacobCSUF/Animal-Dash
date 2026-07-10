extends PlayerState

const state = Player.player_states.STOP
func enter_state(player_node, data = {}):


	super(player_node)
	player.velocity = Vector2(0,0)
	


	
	
