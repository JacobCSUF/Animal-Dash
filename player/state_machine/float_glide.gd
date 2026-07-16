extends PlayerState
const SPEED = 225.0     
const FLOAT_VELOCITY = -5.0


const state = Player.player_states.GLIDE
func enter_state(player_node, _dict = {}):

	super(player_node)
	

func handle_input(delta):
	
	if not player.is_on_floor():
		
		player.icon.rotation_degrees = lerp(player.icon.rotation_degrees,-10.0, .2 * delta * 15)
		
		player.velocity.y = lerp(player.velocity.y, 115.0, delta * 15)
		
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if player.is_test:
		if direction:
			player.velocity.x = lerp(player.velocity.x, direction * SPEED* player.speed_mult, .1 * delta * 60)
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED * delta * 60)
			
	else:
		player.velocity.x = lerp(player.velocity.x,SPEED* player.speed_mult, .1 * delta * 60)
		
		
	if Input.is_action_just_released("e"):
		player.change_state("float")
		
func exit_state():
	
	player.icon.rotation_degrees = 0
