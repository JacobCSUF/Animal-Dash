extends PlayerState
var speed = 450

const state = Player.player_states.THROW

var dash_timer = 0.0

var dir = 1
var end_state: = "flappy"
func enter_state(player_node,data = {}):
	
	if data.has("dir"):
		if data["dir"] == "down":
			dir = -1
		
	end_state = "flappy"
	

#
	super(player_node)
	dash_timer = .40
	var s = player.get_partial_mult(speed,0.5)
	player.velocity = Vector2(s,-speed*dir*.8)


func handle_input(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, 8 * delta * 65)
	player.velocity.y= move_toward(player.velocity.y, 0,8 * delta * 65)
	dash_timer -= delta
	if dash_timer <= 0:
		
		player.change_state("float")

func exit_state():
	
	dir = 1
	dash_timer = 0.0
	
