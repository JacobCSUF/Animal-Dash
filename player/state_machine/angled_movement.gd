extends PlayerState
var swap_angle_degrees = 0
var speed = 400
var angle = 0

var swap_state

const state = Player.player_states.CANNON

func enter_state(player_node, data = {}):

	
	super(player_node)
	
	
	player.velocity *= 0 
	if data.has("angle"):
		swap_angle_degrees = data["angle"]
	
		
	if data.has("speed"):
		speed =  data["speed"]


func handle_input(_delta):
	var angle_rad = deg_to_rad(swap_angle_degrees)
	var direction = Vector2(cos(angle_rad), sin(angle_rad))
	
	player.velocity = direction * speed * player.speed_mult
	if player.is_on_ceiling() or player.is_on_floor():
		player.change_state("ball")
