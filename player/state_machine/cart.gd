extends PlayerState

@onready var cart: Sprite2D = $Cart

const SPEED = 150.0    
const JUMP_VELOCITY = -270.0

func enter_state(player_node, data = {}):
	super(player_node)
	cart.visible = true
	
func handle_input(delta):
	player.velocity.x =  SPEED * player.speed_mult

func exit_state():
	pass
